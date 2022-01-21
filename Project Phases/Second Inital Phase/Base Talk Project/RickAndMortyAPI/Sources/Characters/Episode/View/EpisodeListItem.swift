//
//  EpisodeListItem.swift
//  Base Talk Project
//
//  Created by Tunde on 21/12/2021.
//

import SwiftUI
import Mapper

struct EpisodeListItem: View {
    
    let item: Episode
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 8 ) {
            Text(item.episode)
                .font(.caption2)
            Text(item.airedDate)
                .font(.footnote)
            Text(item.name)
                .font(.title2)
                .bold()
        }
    }
}

struct EpisodeListItem_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListItem(item: .mock)
    }
}
