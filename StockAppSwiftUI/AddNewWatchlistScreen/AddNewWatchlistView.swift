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
    @State private var shakeCount: Int = 0
    
    var body: some View {
        VStack {
            LabeledContent {
                TextField("e.g. tech stocks", text: $viewModel.watchlistText)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        viewModel.onTextFieldSubmitted(text: viewModel.watchlistText)
                    }
                    .focused($isFocused)
                    .onChange(of: isFocused) { isFocused in
                        if isFocused {
                            viewModel.onTextFieldFocused()
                        }
                    }
                    .autocorrectionDisabled()
            } label: {
                Text("Watchlist name: ")
            }
            .modifier(Shake(animatableData: CGFloat(shakeCount)))
            
            if let error = viewModel.error {
                ErrorView(text: error)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.25)) {
                            self.shakeCount += 1
                        }
                    }
            }
            
            Spacer()
        }
        .padding(.horizontal, Self.horizontalPadding)
        .navigationTitle("Add new watchlist")
        .navigationBarTitleDisplayMode(.inline)
    }
}
