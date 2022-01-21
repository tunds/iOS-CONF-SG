//
//  EpisodeMapper.swift
//  Base Talk Project
//
//  Created by Tunde on 09/12/2021.
//

import Foundation

protocol EpisodeMapperImpl {
    typealias Response = EpisodeResultResponse
    func map(from response: Response) -> Episode
}

struct EpisodeMapper: EpisodeMapperImpl {
    
    func map(from response: Response) -> Episode {
        Episode(response)
    }
}
