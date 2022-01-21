//
//  CharactersView.swift
//  Base Talk Project
//
//  Created by Tunde on 25/11/2021.
//

import SwiftUI
import Networking
import Mapper

public struct CharactersView: View {
        
    @StateObject private var vm = CharactersViewModel(
        network: NetworkingManager(),
        characterMapper: CharactersMapper()
    )
    
    public init() {}
    
    public var body: some View {
        
        ZStack {
            
            switch vm.state {
            case .completed(let data):
                configureList(from: data)
            default:
                placeholderVw
            }
        }
        .task { await vm.fetchCharacters() }
        .alert(isPresented: $vm.action.errorOccured,
               error: vm.action.error) { _ in
            Button("Retry") {
                Task {
                    await vm.fetchCharacters()
                }
            }
        } message: { error in
            Text(error.failureReason ?? "")
        }
    }
}

// MARK: - Views

private extension CharactersView {
    
    var placeholderVw: some View {
        ProgressView()
    }
    
    func configureList(from data: CharactersViewModel.Characters) -> some View {
        List {
            ForEach(data,
                    id: \.id) { item in
                CharacterListItem(item: item)
                .navigate(to: CharacterDetailView(item: item))
                .normalizeListItem()
                .task {
                    if vm.shouldPreload(afterViewing: item) {
                        await vm.loadMoreCharacters()
                    }
                }
            }
        }
        .normalizeList()
        .embedInNavigationView(with: "Characters")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
