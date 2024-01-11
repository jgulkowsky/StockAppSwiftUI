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
            // todo: make common
            // todo: maybe (it won't be uikit compilant but maybe we should use bigger titles - they look nicer)
            HStack(alignment: .center) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(.horizontal, 2)
                TextField("Search for symbol to add...", text: $searchText)
            }
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
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
        .navigationBarTitleDisplayMode(.inline)
    }
}

