//
//  CharacterDTO.swift
//  Base Talk Project
//
//  Created by Tunde on 09/12/2021.
//

import Foundation
import SwiftUI

struct Character {

    let id: Int
    let name: String
    let status: Status
    let location: Location
    let species: String
    let image: String
    let episodes: [String]
    
    init(id: Int,
         name: String,
         status: Character.Status,
         location: Location,
         species: String,
         image: String,
         episodes: [String]) {
        self.id = id
        self.name = name
        self.status = status
        self.location = location
        self.species = species
        self.image = image
        self.episodes = episodes
    }
    
    init(_ item: CharacterResultResponse) {
        self.id = item.id
        self.name = item.name
        self.status = Status(rawValue: item.status) ?? .unknown
        self.location = Location(name: item.location.name)
        self.species = item.species
        self.image = item.image
        self.episodes = item.episode
    }
}

extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}

extension Character {
    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
}

extension Character.Status {
    var color: Color {
        switch self {
        case .alive: return .green
        case .dead: return .red
        default: return .gray
        }
    }
}

struct Location: Codable, Equatable {
    let name: String
}

extension Character {
    
    static let mock = Character(id: 1,
                                name: "Rick Sanchez",
                                status: .alive,
                                location: .init(name: "Earth"),
                                species: "Human",
                                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                     episodes: [
                                   "https://rickandmortyapi.com/api/episode/1",
                                   "https://rickandmortyapi.com/api/episode/2"
                                ])
}
