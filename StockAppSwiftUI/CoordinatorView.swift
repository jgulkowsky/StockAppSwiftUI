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
        NavigationStack {
            if coordinator.goToWatchlistsScreen,
               let viewModel = coordinator.watchlistsViewModel {
                WatchlistsView(viewModel: viewModel)
                    .navigationDestination(
                        isPresented: $coordinator.goToAddNewWatchlistScreen,
                        destination: {
                            if let viewModel = coordinator.addNewWatchlistViewModel {
                                AddNewWatchlistView()
                            }
                        }
                    )
                    .navigationDestination(
                        isPresented: $coordinator.goToWatchlistScreen,
                        destination: {
                            if let viewModel = coordinator.watchlistViewModel {
                                WatchlistView(viewModel: viewModel)
                                    .navigationDestination(
                                        isPresented: $coordinator.goToAddNewSymbolScreen,
                                        destination: {
                                            if let viewModel = coordinator.addNewSymbolViewModel {
                                                AddNewSymbolView()
                                            }
                                        }
                                    )
                                    .navigationDestination(
                                        isPresented: $coordinator.goToQuoteScreen,
                                        destination: {
                                            if let viewModel = coordinator.quoteViewModel {
                                                QuoteView(viewModel: viewModel)
                                            }
                                        }
                                    )
                            }
                        }
                    )
            }
        }
    }
}
