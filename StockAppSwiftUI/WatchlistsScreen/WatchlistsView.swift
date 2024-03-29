//
//  WatchlistsView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

struct WatchlistsView: View {
    @ObservedObject var viewModel: WatchlistsViewModel
    
    var body: some View {
        Group {
            if viewModel.state == .loading {
                ProgressView()
            } else if viewModel.state == .error {
                ErrorView(text: viewModel.error ?? "")
            } else if viewModel.state == .dataObtained {
                List {
                    ForEach(Array(viewModel.watchlists.enumerated()), id: \.offset) { index, item in
                        WatchlistsCellView(
                            watchlist: item,
                            action: {
                                viewModel.onItemTapped(at: index)
                            }
                        )
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewModel.onItemSwipedOut(at: Int(index))
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Watchlists")
        .toolbar {
            Button {
                viewModel.onAddButtonTapped()
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.plain)
            .foregroundColor(.blue)
        }
    }
}

