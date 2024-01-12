//
//  CoordinatorObject.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI
import Combine

class CoordinatorObject: Coordinator, ObservableObject {
    @Published var path = NavigationPath()
    @Published var initialViewModel: WatchlistsViewModel?
    
    private var appFirstStartProvider: AppFirstStartProviding!
    private var watchlistsProvider: WatchlistsProviding!
    private var quotesProvider: QuotesProviding!
    private var symbolsProvider: SymbolsProviding!
    private var chartDataProvider: ChartDataProviding!
    
    private var subscription: AnyCancellable?
    
    func initializeWith(
        appFirstStartProvider: AppFirstStartProviding,
        watchlistsProvider: WatchlistsProviding,
        quotesProvider: QuotesProviding,
        symbolsProvider: SymbolsProviding,
        chartDataProvider: ChartDataProviding
    ) {
        self.appFirstStartProvider = appFirstStartProvider
        self.watchlistsProvider = watchlistsProvider
        self.quotesProvider = quotesProvider
        self.symbolsProvider = symbolsProvider
        self.chartDataProvider = chartDataProvider
    }
    
    func onAppStart() {
        self.initialViewModel = WatchlistsViewModel(
            coordinator: self,
            watchlistsProvider: self.watchlistsProvider
        )
        
        if appFirstStartProvider.isFirstAppStart {
            subscription = watchlistsProvider.watchlists
                .receive(on: RunLoop.main)
                .sink { [weak self] watchlists in
                    guard let `self` = self else { return }
                    self.execute(action: .itemSelected(data: watchlists[0]))
                    self.subscription?.cancel()
                    self.appFirstStartProvider.setAppFirstStarted()
                }
        }
    }
    
    func execute(action: Action) {
        switch action {
        case .itemSelected(let data):
            if let watchlist = data as? Watchlist {
                self.path.append(
                    WatchlistViewModel(
                        coordinator: self,
                        watchlistsProvider: self.watchlistsProvider,
                        quotesProvider: self.quotesProvider,
                        watchlist: watchlist,
                        refreshRate: 5
                    )
                )
            } else if let stockItem = data as? StockItem {
                self.path.append(
                    QuoteViewModel(
                        coordinator: self,
                        quotesProvider: self.quotesProvider,
                        chartDataProvider: self.chartDataProvider,
                        symbol: stockItem.symbol,
                        refreshRate: 5
                    )
                )
            }
        case .addButtonTapped(let data):
            if let watchlist = data as? Watchlist {
                self.path.append(
                    AddNewSymbolViewModel(
                        coordinator: self,
                        watchlistsProvider: self.watchlistsProvider,
                        symbolsProvider: self.symbolsProvider,
                        watchlist: watchlist,
                        searchTextDebounceMillis: 500
                    )
                )
            } else {
                self.path.append(
                    AddNewWatchlistViewModel(
                        coordinator: self,
                        watchlistsProvider: self.watchlistsProvider
                    )
                )
            }
        case .inputSubmitted:
            path.removeLast()
        }
    }
}
