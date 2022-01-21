//
//  CharactersMapper.swift
//  Base Talk Project
//
//  Created by Tunde on 09/12/2021.
//

import Foundation
import Models

public protocol CharactersMapperImpl {
    typealias Response = APIResponse<CharacterResultResponse>
    func map(from response: Response) -> [Character]
}

public struct CharactersMapper: CharactersMapperImpl {
    
    public init() {}
    
    public func map(from response: Response) -> [Character] {
        response.results.compactMap(Character.init)
    }
}
