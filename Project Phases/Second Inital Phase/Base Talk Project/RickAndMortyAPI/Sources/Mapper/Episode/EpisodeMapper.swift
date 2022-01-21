//
//  EpisodeMapper.swift
//  Base Talk Project
//
//  Created by Tunde on 09/12/2021.
//

import Foundation
import Models

public protocol EpisodeMapperImpl {
    typealias Response = EpisodeResultResponse
    func map(from response: Response) -> Episode
}

public struct EpisodeMapper: EpisodeMapperImpl {
    
    public init() {}
    
    public func map(from response: Response) -> Episode {
        Episode(response)
    }
}
