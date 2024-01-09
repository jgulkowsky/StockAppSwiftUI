//
//  WatchlistView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

struct WatchlistView: View {
    @ObservedObject var viewModel: WatchlistViewModel
    
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
                    Section {
                        ForEach(Array(viewModel.stockItems.enumerated()), id: \.offset) { index, item in
                            WatchlistCellView(
                                item: item,
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
                    } header: {
                        WatchlistHeaderView(
                            items: ["name", "bid price", "ask price", "last price"]
                        )
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.onAddButtonTapped()
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.plain)
        }
        .onAppear(perform: viewModel.onViewWillAppear)
        .onDisappear(perform: viewModel.onViewWillDisappear)
    }
}

