//
//  URL.swift
//  HW21
//
//  Created by Anton on 06.11.2022.
//

import Foundation

struct CharacterURL {
    private var components = URLComponents()
    
    private let scheme = "https"
    private let host = "gateway.marvel.com"
    private let path = "/v1/public/characters"
    
    private let name = "name"
    private let ts = "hw19"
    private let publicKey = "ca67588a7b5d724d5f0da0314d1e34a8"
    private let privateKey = "5c8b05e986cb96534bb107c990e494e1982bc42d"
    private var queryItems: [URLQueryItem] = []
    
    private var hash: String {
        (ts + privateKey + publicKey).md5()
    }
    
    init(characterName: String = "") {
        setURL(with: characterName)
    }
    
    private mutating func setURL(with characterName: String) {
        components.scheme = scheme
        components.host = host
        components.path = path
        setQueryItems(with: characterName)
        components.queryItems = queryItems
    }
    
    private mutating func setQueryItems(with characterName: String) {
        if characterName != "" {
            queryItems.append(URLQueryItem(name: name, value: characterName))
        }
        queryItems.append(contentsOf: [URLQueryItem(name: "ts", value: ts),
                                       URLQueryItem(name: "apikey", value: publicKey),
                                       URLQueryItem(name: "hash", value: hash)])
    }
    
    public func getStringURL() -> String {
        components.string ?? "Error"
    }
    
    public func getStringQueryItems() -> String {
        components.string?.components(separatedBy: "characters").last ?? "Error"
    }
}
