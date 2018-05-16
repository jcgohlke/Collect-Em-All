//
//  CharacterListTableViewController.swift
//  Collect-Em-All
//
//  Created by Ben Gohlke on 10/22/15.
//  Copyright © 2015 Joben Gohlke. All rights reserved.
//

import UIKit

class CharacterListTableViewController: UITableViewController
{

    var characters: [Character]?
    var delegate: CharacterListTableViewControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return characters!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)

        // Configure the cell...
        if let aCharacter = characters?[indexPath.row]
        {
            cell.textLabel?.text = aCharacter.name
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.characterWasChosen((characters?[indexPath.row])!)
    }
}
