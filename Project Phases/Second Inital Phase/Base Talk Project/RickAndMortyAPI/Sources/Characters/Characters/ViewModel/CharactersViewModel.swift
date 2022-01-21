//
//  HomeViewModel.swift
//  Base Talk Project
//
//  Created by Tunde on 25/11/2021.
//

import Foundation
import Algorithms
import Networking
import Mapper
import Models

@MainActor
final class CharactersViewModel: ObservableObject {
    
    struct RequestAction {
        var errorOccured: Bool = false
        var error: NetworkingError?
    }
    
    struct RequestConfig {
        var page: Int = 1
        let count: Int = 10
        
        mutating func increase() {
            page += 1
        }
    }
    
    typealias Characters = [Character]

    @Published var state: NetworkingState<Characters, NetworkingError> = .idle
    @Published var action: RequestAction = .init()

    private var fetchedCharacters: Characters {
        guard case let .completed(characters) = state else { return [] }
        return characters
    }
    private var requestConfig: RequestConfig = .init()
    private let network: NetworkingManagerImpl
    private let characterMapper: CharactersMapperImpl

    init(network: NetworkingManagerImpl,
         characterMapper: CharactersMapperImpl) {
        self.network = network
        self.characterMapper = characterMapper
    }
    
    func shouldPreload(afterViewing item: Character) -> Bool {
        guard !fetchedCharacters.isEmpty else { return false }
        let preloadIndex = fetchedCharacters.count - 5
        return item.id == fetchedCharacters[preloadIndex].id
    }
    
    func fetchCharacters() async {
        
        guard fetchedCharacters.isEmpty else { return }
        
        defer {
            self.action = .init(errorOccured: state.hasError,
                                error: state.failureReason)
        }
        
        self.state = .loading
        
        var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!

        components.queryItems = [
            URLQueryItem(name: "page", value: requestConfig.page.description),
            URLQueryItem(name: "count", value: requestConfig.count.description)
        ]
    
        do {
            let response = try await network.execute(request: .init(url: components.url!),
                                                     responseType: APIResponse<CharacterResultResponse>.self)
            self.state = .completed(data: characterMapper.map(from: response))
        } catch {
            if let error = error as? NetworkingError {
                self.state = .failed(error: error)
            } else {
                self.state = .failed(error: .requestFailed(reason: error))
            }
        }
    }
    
    func loadMoreCharacters() async {
    
        guard !fetchedCharacters.isEmpty else { return }
        
        requestConfig.increase()
        
        var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!

        components.queryItems = [
            URLQueryItem(name: "page", value: requestConfig.page.description),
            URLQueryItem(name: "count", value: requestConfig.count.description)
        ]
    
        do {
            let response = try await network.execute(request: .init(url: components.url!),
                                                     responseType: APIResponse<CharacterResultResponse>.self)
             
            let mappedCharacters = characterMapper.map(from: response)
            self.state = .completed(data: Array(chain(fetchedCharacters, mappedCharacters)))
        } catch {
            if let error = error as? NetworkingError {
                self.state = .failed(error: error)
            } else {
                self.state = .failed(error: .requestFailed(reason: error))
            }
        }
    }
}
