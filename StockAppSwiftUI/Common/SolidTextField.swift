//
//  SolidTextField.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 12/01/2024.
//

import SwiftUI

struct SolidTextField: View {
    @Binding var searchText: String
    var placeholder: String
    var icon: String?
    
    var body: some View {
        Group {
            if let icon = icon {
                HStack(alignment: .center) {
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(.horizontal, 2)
                    TextField(placeholder, text: $searchText)
                        .padding(.trailing, 7)
                }
            } else {
                TextField(placeholder, text: $searchText)
                    .padding(.horizontal, 7)
            }
        }
        .padding(7)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct CommonTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SolidTextField(
                searchText: .constant(""),
                placeholder: "placeholder"
            )
            SolidTextField(
                searchText: .constant(""),
                placeholder: "Search for symbol to add...",
                icon: "magnifyingglass"
            )
            SolidTextField(
                searchText: .constant("some search term"),
                placeholder: "Search for symbol to add...",
                icon: "star"
            )
            SolidTextField(
                searchText: .constant(""),
                placeholder: "this-is-broken-field-as-icon-doesnt-exist",
                icon: "sorry-this-icon-is-not-a-valid-sf-symbol"
            )
        }
        .padding()
    }
}
