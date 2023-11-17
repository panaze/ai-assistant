//
//  SearchBar.swift
//  ChatGPT
//
//  Created by Pablo Navarro Zepeda on 16/11/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("SearchBarInsideColor"))

            TextField("", text: $text)
                .modifier(PlaceholderModifier(
                    showPlaceholder: text.isEmpty,
                    placeholder: "Search",
                    placeholderColor: Color("SearchBarInsideColor")
                ))
        }
        .padding(8)
        .background(Color("SearchBarColor"))
        .cornerRadius(10)
        .frame(maxWidth: .infinity) 
    }
}


struct PlaceholderModifier: ViewModifier {
    var showPlaceholder: Bool
    var placeholder: String
    var placeholderColor: Color

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceholder {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.leading, 5)
            }
            content
            .foregroundColor(placeholderColor)
        }
    }
}
