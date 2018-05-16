//
//  CharacterDetailViewController.swift
//  Collect-Em-All
//
//  Created by Joben Gohlke on 1/12/17.
//  Copyright © 2017 Joben Gohlke. All rights reserved.
//

import UIKit
import SafariServices

class CharacterDetailViewController: UIViewController
{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var homeworldLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    
    @IBOutlet var headingLabels: [UILabel]!
    
    var character: Character?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let aCharacter = character
        {
            title = aCharacter.name
            imageView.image = UIImage(named: aCharacter.name)
            homeworldLabel.text = aCharacter.homeworld
            genderLabel.text = aCharacter.gender
            birthYearLabel.text = aCharacter.birthYear
            hairColorLabel.text = aCharacter.hairColor
            eyeColorLabel.text = aCharacter.eyeColor
        }
        
        headingLabels.forEach { $0.attributedText = NSAttributedString(string: $0.text!, attributes: [NSAttributedStringKey.kern: 0.8]) }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openWookieepedia()
    {
        if let aCharacter = character
        {
            let urlSanitizedName = aCharacter.name.replacingOccurrences(of: " ", with: "_")
            let wookieUrl = URL(string: "https://starwars.wikia.com/wiki/\(urlSanitizedName)")!
            let safariVC = SFSafariViewController(url: wookieUrl)
            present(safariVC, animated: true, completion: nil)
        }
    }
}
