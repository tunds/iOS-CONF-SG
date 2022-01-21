//
//  CharacterListItem.swift
//  Base Talk Project
//
//  Created by Tunde on 28/11/2021.
//

import SwiftUI
import Helpers
import Mapper

struct CharacterListItem: View {
    
    let item: Character
    
    var body: some View {
        
        HStack(alignment: .top) {
            characterImg
            VStack(alignment: .leading,
                   spacing: 12) {
                characterTitle
                characterLocation
                characterApperances
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            Spacer()
        }
        .frame(height: 180)
        .normalizeListItem()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

private extension CharacterListItem {
    
    var characterImg: some View {
        AsyncImage(url: URL(string: item.image)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 150, height: 180)
        .background(.gray)
    }
    
    var characterTitle: some View {
        VStack(alignment: .leading,
               spacing: 4) {
            
            Text(item.name)
                .font(.title2)
                .bold()
            
            HStack {
                item.status.color
                    .frame(width: 10, height: 10)
                    .clipShape(Circle())
                Text("\(item.status.rawValue) - \(item.species)")
                    .font(.subheadline)
            }
        }
    }
    
    var characterLocation: some View {
        VStack(alignment: .leading,
               spacing: 4) {
            
            Text("Last known location:")
                .font(.caption)
                .bold()
            
            Text(item.location.name)
                .font(.callout)
                .lineLimit(1)
        }
    }
    
    var characterApperances: some View {
        VStack(alignment: .leading,
               spacing: 4) {
            
            Text("Total Apperances:")
                .font(.caption)
                .bold()
            
            Text(item.episodes.count.description)
                .font(.callout)
        }
    }
}

struct HomeListItem_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListItem(item: .mock)
    }
}
