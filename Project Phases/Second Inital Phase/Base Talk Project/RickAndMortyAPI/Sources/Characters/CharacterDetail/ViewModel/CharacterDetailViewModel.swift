//
//  CharacterDetailViewModel.swift
//  Base Talk Project
//
//  Created by Tunde on 21/12/2021.
//

import Foundation
import Networking
import Mapper
import Models

@MainActor
final class CharactersDetailViewModel: ObservableObject {
    
    struct RequestAction {
        var errorOccured: Bool = false
        var error: NetworkingError?
    }
    
    typealias Episodes = [Episode]

    @Published var state: NetworkingState<Episodes, NetworkingError> = .idle
    @Published var action: RequestAction = .init()

    private let network: NetworkingManagerImpl
    private let episodeMapper: EpisodeMapperImpl

    init(network: NetworkingManagerImpl,
         episodeMapper: EpisodeMapperImpl) {
        self.network = network
        self.episodeMapper = episodeMapper
    }
    
    func fetchEpisodes(for character: Character) async {
        
        defer {
            self.action = .init(errorOccured: state.hasError,
                                error: state.failureReason)
        }
        
        self.state = .loading
        
        do {
            
            var episodes = [Episode]()
            
            try await withThrowingTaskGroup(of: Episode.self) { group in
                for episode in character.episodes {
                    group.addTask { [self] in
                        let url = URL(string: episode)
                        let request = URLRequest(url: url!)
                        let episodeResponse = try await self.network.execute(request: request, responseType: EpisodeResultResponse.self)
                        return episodeMapper.map(from: episodeResponse)
                    }
    
                    for try await episode in group {
                        episodes.append(episode)
                    }
                }
            }
            
            self.state = .completed(data: episodes)

        } catch {
            if let error = error as? NetworkingError {
                self.state = .failed(error: error)
            } else {
                self.state = .failed(error: .requestFailed(reason: error))
            }
        }
    }
}
