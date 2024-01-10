//
//  StockAppSwiftUIApp.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

// todo: maybe such typealiasing could be in StockAppLogicSwiftUI so we don't have to write it here?
typealias WatchlistsViewModel = StockAppLogicSwiftUI.WatchlistsViewModel
typealias AddNewWatchlistViewModel = StockAppLogicSwiftUI.AddNewWatchlistViewModel
typealias WatchlistViewModel = StockAppLogicSwiftUI.WatchlistViewModel
typealias AddNewSymbolViewModel = StockAppLogicSwiftUI.AddNewSymbolViewModel
typealias QuoteViewModel = StockAppLogicSwiftUI.QuoteViewModel

@main
struct StockAppSwiftUIApp: App {
    @StateObject private var coordinator = CoordinatorObject()

    var body: some Scene {
        WindowGroup {
            ContentView(
                coordinator: coordinator
            )
            .onAppear {
                let appFirstStartProvider = AppFirstStartProvider()
                let watchlistsCoreDataProvider = MockWatchlistsCoreDataProvider()
                let watchlistsProvider = WatchlistsProvider(
                    coreDataProvider: watchlistsCoreDataProvider,
                    appFirstStartProvider: appFirstStartProvider,
                    initialList: Watchlist(
                        id: UUID(),
                        name: "My First List",
                        symbols: ["AAPL", "GOOG", "MSFT"]
                    )
                )
                let apiFetcher = ApiFetcher()
                let quotesProvider = QuotesProvider(apiFetcher: apiFetcher)
                let symbolsProvider = SymbolsProvider(apiFetcher: apiFetcher)
                let chartDataProvider = ChartDataProvider(apiFetcher: apiFetcher)
                
                coordinator.initializeWith(
                    appFirstStartProvider: appFirstStartProvider,
                    watchlistsProvider: watchlistsProvider,
                    quotesProvider: quotesProvider,
                    symbolsProvider: symbolsProvider,
                    chartDataProvider: chartDataProvider
                )
                coordinator.onAppStart()
            }
        }
    }
}
