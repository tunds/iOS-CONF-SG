//
//  CharactersMapper.swift
//  Base Talk Project
//
//  Created by Tunde on 09/12/2021.
//

import Foundation

protocol CharactersMapperImpl {
    typealias Response = APIResponse<CharacterResultResponse>
    func map(from response: Response) -> [Character]
}

struct CharactersMapper: CharactersMapperImpl {
    
    func map(from response: Response) -> [Character] {
        response.results.compactMap(Character.init)
    }
}
