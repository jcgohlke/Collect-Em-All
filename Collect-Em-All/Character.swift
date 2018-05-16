//  Character.swift
//  Collect-Em-All
//
//  Created by Ben Gohlke on 5/16/18.
//  Copyright © 2018 Joben Gohlke. All rights reserved.
//

import Foundation

struct Character : Codable, Equatable
{
    let name: String
    let homeworld: String
    let eyeColor: String
    let hairColor: String
    let gender: String
    let birthYear: String
    
    enum CodingKeys : String, CodingKey
    {
        case name
        case homeworld
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case gender
        case birthYear = "birth_year"
    }
    
    static func ==(lhs: Character, rhs: Character) -> Bool
    {
        return lhs.name == rhs.name
    }
}
