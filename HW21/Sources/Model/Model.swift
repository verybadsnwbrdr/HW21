//
//  Model.swift
//  HW21
//
//  Created by Anton on 06.11.2022.
//

import Foundation

struct CharacterDataWrapper: Decodable {
    let code: Int
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let thumbnail: Image
}

struct Image: Decodable {
    let path: String
    let extensionOfImage: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionOfImage = "extension"
    }
}
