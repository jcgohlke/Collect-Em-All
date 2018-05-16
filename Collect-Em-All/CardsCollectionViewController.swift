//
//  CardsCollectionViewController.swift
//  Collect-Em-All
//
//  Created by Ben Gohlke on 10/22/15.
//  Copyright © 2015 Joben Gohlke. All rights reserved.
//

import UIKit

protocol CharacterListTableViewControllerDelegate
{
    func characterWasChosen(_ chosenCharacter: Character)
}

class CardsCollectionViewController: UICollectionViewController
{
    var visibleCards = [Character]()
    
    var allCharacters = [Character]()
    var remainingCharacters = [Character]()
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Collect 'Em All"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        loadCharacters()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowCharacterListPopoverSegue"
        {
            let destVC = segue.destination as! CharacterListTableViewController
            destVC.characters = remainingCharacters
            destVC.popoverPresentationController?.delegate = self
            destVC.delegate = self
            let contentHeight = 44.0 * CGFloat(remainingCharacters.count)
            destVC.preferredContentSize = CGSize(width: 200.0, height: contentHeight)
        }
        else if segue.identifier == "ShowCharacterDetailSegue"
        {
            let destVC = segue.destination as! CharacterDetailViewController
            let cell = sender as! CardCell
            let indexPath = collectionView?.indexPath(for: cell)!
            let character = visibleCards[(indexPath?.row)!]
            destVC.character = character
        }
    }

    // MARK: - Loading Data
    
    func loadCharacters()
    {
        if let filePath = Bundle.main.path(forResource: "characters", ofType: "json") {
            do {
                let jsonString = try String(contentsOfFile: filePath)
                let jsonData = jsonString.data(using: .utf8)!
                let decoder = JSONDecoder()
                allCharacters = try decoder.decode([Character].self, from: jsonData)
                remainingCharacters = allCharacters
            } catch {
                print("Error finding characters file or decoding json data from it.")
            }
        }
    }
}

extension CardsCollectionViewController : UIPopoverPresentationControllerDelegate
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return visibleCards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
    
        // Configure the cell
        let aCharacter = visibleCards[indexPath.item]
        cell.nameLabel.text = aCharacter.name
        cell.imageView.image = UIImage(named: aCharacter.name)
    
        return cell
    }
}

extension CardsCollectionViewController
{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .none
    }
}

extension CardsCollectionViewController : CharacterListTableViewControllerDelegate
{
    
    func characterWasChosen(_ chosenCharacter: Character)
    {
        navigationController?.dismiss(animated: true, completion: nil)
        visibleCards.append(chosenCharacter)
        
        let characterIndexToRemove = remainingCharacters.index(of: chosenCharacter)!
        remainingCharacters.remove(at: characterIndexToRemove)
        if remainingCharacters.count == 0
        {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        collectionView?.reloadData()
    }
}
