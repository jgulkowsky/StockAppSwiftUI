//
//  AddNewSymbolView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

struct AddNewSymbolView: View {
    @ObservedObject var viewModel: AddNewSymbolViewModel
    @State private var searchText: String = ""
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            SolidTextField(
                searchText: $searchText,
                placeholder: "Search for symbol to add...",
                icon: "magnifyingglass"
            )
            .padding(.top, 5)
            .autocorrectionDisabled()
            .onChange(of: searchText) { value in
                viewModel.onSearchTextChanged(to: value)
            }
            .focused($isFocused)
            .onAppear {
                isFocused = true
            }
            
            List {
                ForEach(Array(viewModel.symbols.enumerated()), id: \.offset) { index, symbol in
                    AddNewSymbolCellView(
                        symbol: symbol,
                        action: {
                            viewModel.onItemTapped(at: index)
                            dismiss()
                        }
                    )
                }
            }
            .listStyle(.plain)
        }
        .padding(.horizontal, Self.horizontalPadding)
        .navigationTitle("Add new symbol")
    }
}

