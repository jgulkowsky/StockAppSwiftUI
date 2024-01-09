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
    // todo: add .autocorrectionDisabled() somehow - maybe with @environment - there's sth about this
    
    var body: some View {
        List {
            ForEach(Array(viewModel.symbols.enumerated()), id: \.offset) { index, symbol in
                SymbolCellView(
                    symbol: symbol,
                    action: {
                        viewModel.onItemTapped(at: index)
                        dismiss()
                    }
                )
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText, prompt: " Search for symbol to add...")
        .onChange(of: searchText) { value in
            viewModel.onSearchTextChanged(to: value)
        }
    }
}

