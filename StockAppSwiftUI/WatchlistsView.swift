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
    
    // todo: this could be shared accross UIKit and SwiftUI project - as well as styles of Views (another package?)
    private static let horizontalPadding: CGFloat = 20.0
    private static let errorTextPaddingTop: CGFloat = 15.0
    
    var body: some View {
        Group {
            if viewModel.state == .loading {
                ProgressView()
            } else if viewModel.state == .error {
                Text(viewModel.error ?? "") // todo: style same as in UIKit app
                    .padding(.top, Self.errorTextPaddingTop)
                    .padding(.horizontal, Self.horizontalPadding)
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
                            viewModel.onItemSwipedOut(at: Int(index)) // todo: it (or the viewModel logic) behaves strange when removing index 0
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Watchlists")
        .navigationBarTitleDisplayMode(.inline)
    }
}

