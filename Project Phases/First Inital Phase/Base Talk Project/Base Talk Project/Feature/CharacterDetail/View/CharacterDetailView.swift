//
//  CharacterDetailView.swift
//  Base Talk Project
//
//  Created by Tunde on 21/12/2021.
//

import SwiftUI

struct CharacterDetailView: View {

    @StateObject private var vm = CharactersDetailViewModel(
        network: NetworkingManager(),
        episodeMapper: EpisodeMapper()
    )
    
    let item: Character
    
    var body: some View {
        List {
            
            characterImg
            
            Section(header: Text("Info")) {
                species
                status
                location
            }
            .headerProminence(.increased)
                
            Section(header: Text("Featured Episodes")) {
                
                switch vm.state {
                case .completed(let data):
                    configureList(from: data)
                default:
                    placeholderVw
                        .centre()
                }
            }
            .headerProminence(.increased)
        }
        .navigationTitle(item.name)
        .task { await vm.fetchEpisodes(for: item) }
        .alert(isPresented: $vm.action.errorOccured,
               error: vm.action.error) { _ in
            Button("Retry") {
                Task {
                    await vm.fetchEpisodes(for: item) 
                }
            }
        } message: { error in
            Text(error.failureReason ?? "")
        }
    }
}

private extension CharacterDetailView {
    var characterImg: some View {
        AsyncImage(url: URL(string: item.image)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            ProgressView()
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .listRowInsets(EdgeInsets())
        .background(.gray)
    }
}

private extension CharacterDetailView {
    
    var species: some View {
        HStack {
            createTitleLbl("Species")
            Spacer()
            createSubtitleLbl(item.species)
        }
    }
    
    var status: some View {
        HStack {
            createTitleLbl("Status")
            Spacer()
            HStack(spacing: 5) {
                item.status.color
                    .frame(width: 10, height: 10)
                    .clipShape(Circle())
                createSubtitleLbl(item.status.rawValue)
            }
        }
    }
    
    var location: some View {
        HStack {
            createTitleLbl("Location")
            Spacer()
            createSubtitleLbl(item.location.name)
        }
    }
}

private extension CharacterDetailView {
    
    func createTitleLbl(_ title: String) -> some View {
        Text(title)
            .font(.headline)
    }
    
    func createSubtitleLbl(_ title: String) -> some View {
        Text(title)
            .font(.subheadline)
    }
}

private extension CharacterDetailView {
    
    var placeholderVw: some View {
        ProgressView()
    }
    
    func configureList(from data: CharactersDetailViewModel.Episodes) -> some View {
        ForEach(data,
                id: \.id) { EpisodeListItem(item: $0) }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailView(item: .mock)
        }
    }
}
