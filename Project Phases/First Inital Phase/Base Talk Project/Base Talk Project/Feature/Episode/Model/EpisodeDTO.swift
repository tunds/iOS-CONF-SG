//
//  EpisodeDTO.swift
//  Base Talk Project
//
//  Created by Tunde on 09/12/2021.
//

import Foundation

struct Episode {

    let id: Int
    let name: String
    let episode: String
    let airedDate: String
    
    init(id: Int,
         name: String,
         episode: String,
         airedDate: String) {
        self.id = id
        self.name = name
        self.episode = episode
        self.airedDate = airedDate
    }
    
    init(_ item: EpisodeResultResponse) {
        self.id = item.id
        self.name = item.name
        self.episode = item.episode
        self.airedDate = item.airDate
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id == rhs.id
    }
}

extension Episode {
    
    static let mock = Episode(id: 28,
                              name: "Rick Sanchez",
                              episode: "The Ricklantins Mixup",
                              airedDate: "September 10, 2017")
}
