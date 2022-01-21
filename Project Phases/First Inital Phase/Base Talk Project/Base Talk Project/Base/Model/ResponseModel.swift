//
//  ResponseModel.swift
//  Base Talk Project
//
//  Created by Tunde on 22/11/2021.
//

import SwiftUI

// MARK: - Character

struct APIResponse<T: Codable>: Codable {
    let info: APIInfoResponse
    let results: [T]
}

struct APIInfoResponse: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}

// MARK: - Character

struct CharacterResultResponse: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: CharacterLocationResponse
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterLocationResponse: Codable {
    let name: String
    let url: String
}

// MARK: - Episode

struct EpisodeResultResponse: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url
    }
}
