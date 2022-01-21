//
//  TestView.swift
//  Base Talk Project
//
//  Created by Tunde on 29/12/2021.
//

import SwiftUI

struct TestView: View {
    
    @State private var isActive = false
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundColor(isActive ? .green : .red)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
