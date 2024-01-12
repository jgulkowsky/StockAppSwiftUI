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
        if let viewModel = coordinator.initialViewModel {
            NavigationStack(path: $coordinator.path) {
                WatchlistsView(viewModel: viewModel)
                    .navigationDestination(for: AddNewWatchlistViewModel.self) {
                        AddNewWatchlistView(viewModel: $0)
                    }
                    .navigationDestination(for: WatchlistViewModel.self) {
                        WatchlistView(viewModel: $0)
                            .navigationDestination(for: AddNewSymbolViewModel.self) {
                                AddNewSymbolView(viewModel: $0)
                            }
                            .navigationDestination(for: QuoteViewModel.self) {
                                QuoteView(viewModel: $0)
                            }
                    }
            }
        }
    }
}
