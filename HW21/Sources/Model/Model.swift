//
//  Model.swift
//  HW21
//
//  Created by Anton on 06.11.2022.
//

import Foundation

// MARK: - Character

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
    let comics: ComicList
}

struct ComicList: Decodable {
    let items: [ComicSummary]
}

struct ComicSummary: Decodable {
    let resourceURI: String
    let name: String
}

struct Image: Decodable {
    let path: String
    let extensionOfImage: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionOfImage = "extension"
    }
}

// MARK: Comics

struct ComicDataWrapper: Decodable {
    let data: ComicDataContainer
}

struct ComicDataContainer: Decodable {
    let results: [Comic]
}

struct Comic: Decodable {
    let title: String
    let thumbnail: Image
}
