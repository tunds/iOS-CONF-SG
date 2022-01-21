//
//  ResponseModel.swift
//  Base Talk Project
//
//  Created by Tunde on 22/11/2021.
//

import SwiftUI

// MARK: - Character

public struct APIResponse<T: Codable>: Codable {
    public let info: APIInfoResponse
    public let results: [T]
}

public struct APIInfoResponse: Codable {
    public let count, pages: Int
    public let next: String
    public let prev: String?
}

// MARK: - Character

public struct CharacterResultResponse: Codable {
    public let id: Int
    public let name, status, species, type: String
    public let gender: String
    public let origin, location: CharacterLocationResponse
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}

public struct CharacterLocationResponse: Codable {
    public let name: String
    public let url: String
}

// MARK: - Episode

public struct EpisodeResultResponse: Codable {
    public let id: Int
    public let name, airDate, episode: String
    public let characters: [String]
    public let url: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url
    }
}
