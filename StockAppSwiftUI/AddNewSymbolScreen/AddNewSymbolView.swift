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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            SolidTextField(
                searchText: $searchText,
                placeholder: "Search for symbol to add...",
                icon: "magnifyingglass"
            )
            .autocorrectionDisabled()
            .onChange(of: searchText) { value in
                viewModel.onSearchTextChanged(to: value)
            }
            
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
        .navigationTitle("Add new symbol")
    }
}

