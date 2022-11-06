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

    private let ts = "hw19"
    private let publicKey = "ca67588a7b5d724d5f0da0314d1e34a8"
    private let privateKey = "5c8b05e986cb96534bb107c990e494e1982bc42d"
    
    private var hash: String {
        (ts + privateKey + publicKey).md5()
    }
    
    init() {
        set()
    }
    
    private mutating func set() {
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [URLQueryItem(name: "ts", value: ts),
                                 URLQueryItem(name: "apikey", value: publicKey),
                                 URLQueryItem(name: "hash", value: hash)]
    }
    
    public func getStringUrl() -> String {
        components.string ?? "Error"
    }
}
