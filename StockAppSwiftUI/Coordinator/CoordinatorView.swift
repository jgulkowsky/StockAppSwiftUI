//
//  CoordinatorView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI

struct CoordinatorView: View {
    @ObservedObject var coordinator: CoordinatorObject
    
    var body: some View {
        if let viewModel = coordinator.watchlistsViewModel {
            NavigationStack(path: $coordinator.path) {
                WatchlistsView(viewModel: viewModel)
                    .navigationDestination(for: AddNewWatchlistViewModel.self) { viewModel in
                        if let viewModel = viewModel {
                            AddNewWatchlistView(viewModel: viewModel)
                        }
                    }
                    .navigationDestination(for: WatchlistViewModel.self) { viewModel in
                        if let viewModel = viewModel {
                            WatchlistView(viewModel: viewModel)
                                .navigationDestination(for: AddNewSymbolViewModel.self) { viewModel in
                                    if let viewModel = viewModel {
                                        AddNewSymbolView(viewModel: viewModel)
                                    }
                                }
                                .navigationDestination(for: QuoteViewModel.self) { viewModel in
                                    if let viewModel = viewModel {
                                        QuoteView(viewModel: viewModel)
                                    }
                                }
                        }
                    }
            }
        }
    }
}
