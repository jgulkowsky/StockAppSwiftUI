//
//  CoordinatorObject.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

class CoordinatorObject: Coordinator, ObservableObject {
    @Published var goToWatchlistScreen: Bool = false {
        didSet {
            if goToWatchlistScreen == false {
                watchlistViewModel = nil
            }
        }
    }
    
    @Published var goToQuoteScreen: Bool = false {
        didSet {
            if goToQuoteScreen == false {
                quoteViewModel = nil
            }
        }
    }
    
    @Published var watchlistViewModel: WatchlistViewModel?
    @Published var quoteViewModel: QuoteViewModel?
    
    // todo: it would be nice to inject these things and not create them in CoordinatorObject but it's problematic to inject into the StateObject - for now I'm leaving it as it is - when app is ready then I can try to fix this problem
    
    private let appFirstStartProvider: AppFirstStartProvider
    private let watchlistsCoreDataProvider: MockWatchlistsCoreDataProvider
    private let watchlistsProvider: WatchlistsProvider
    private let apiFetcher: ApiFetcher
    private let quotesProvider: QuotesProvider
    private let symbolsProvider: SymbolsProvider
    private let chartDataProvider: ChartDataProvider
    
    private var currentViewModel: Any?
    
    init() {
        self.appFirstStartProvider = AppFirstStartProvider()
        self.watchlistsCoreDataProvider = MockWatchlistsCoreDataProvider()
        self.watchlistsProvider = WatchlistsProvider(
            coreDataProvider: watchlistsCoreDataProvider,
            appFirstStartProvider: appFirstStartProvider,
            initialList: Watchlist(
                id: UUID(),
                name: "My First List",
                symbols: ["AAPL", "GOOG", "MSFT"]
            )
        )
        self.apiFetcher = ApiFetcher()
        self.quotesProvider = QuotesProvider(apiFetcher: apiFetcher)
        self.symbolsProvider = SymbolsProvider(apiFetcher: apiFetcher)
        self.chartDataProvider = ChartDataProvider(apiFetcher: apiFetcher)
        
        self.onAppStart()
    }
    
    func onAppStart() {
        // todo: add same setup as in UIKit app later on
        self.watchlistViewModel = WatchlistViewModel(
            coordinator: self,
            watchlistsProvider: self.watchlistsProvider,
            quotesProvider: self.quotesProvider,
            watchlist: self.watchlistsCoreDataProvider.getWatchlists()[0],
            refreshRate: 5
        )
        self.currentViewModel = watchlistViewModel
        self.goToWatchlistScreen = true
    }
    
    func execute(action: Action) {
        if currentViewModel is WatchlistViewModel {
            switch action {
            case .itemSelected(let data):
                if let stockItem = data as? StockItem {
                    self.quoteViewModel = QuoteViewModel(
                        coordinator: self,
                        quotesProvider: self.quotesProvider,
                        chartDataProvider: self.chartDataProvider,
                        symbol: stockItem.symbol,
                        refreshRate: 5
                    )
                    self.goToQuoteScreen = true
                }
            default:
                return
            }
        }
    }
}
