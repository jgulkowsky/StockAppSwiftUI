//
//  AddNewWatchlistView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

struct AddNewWatchlistView: View {
    @ObservedObject var viewModel: AddNewWatchlistViewModel
    @FocusState private var isFocused: Bool
    
    // todo: this could be shared accross UIKit and SwiftUI project - as well as styles of Views (another package?)
    private static let horizontalPadding: CGFloat = 20.0
    private static let errorTextPaddingTop: CGFloat = 15.0
    
    var body: some View {
        VStack {
            LabeledContent {
                TextField("e.g. tech stocks", text: $viewModel.watchlistText) // todo: add light border
                    .onSubmit {
                        viewModel.onTextFieldSubmitted(text: viewModel.watchlistText)
                    }
                    .focused($isFocused)
                    .onChange(of: isFocused) { isFocused in
                        if isFocused {
                            viewModel.onTextFieldFocused(initialText: viewModel.watchlistText) // todo: generally viewModels doesn't use this initialText value so we can update the package and both clients using this method
                        }
                    }
                    .autocorrectionDisabled()
            } label: {
                Text("Watchlist name:")
            }
            
            if let error = viewModel.error {
                Text(error)
                    .padding(.top, Self.errorTextPaddingTop)
                    .foregroundColor(.red) // todo: add shaking animation
            }
            
            Spacer()
        }
        .padding(.horizontal, Self.horizontalPadding)
        .navigationTitle("Add new watchlist")
        .navigationBarTitleDisplayMode(.inline)
    }
}

