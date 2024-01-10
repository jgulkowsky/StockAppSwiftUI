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
    @Published var goToWatchlistsScreen: Bool = false {
        didSet {
            if goToWatchlistsScreen == false {
                watchlistsViewModel = nil
            }
        }
    }
    
    @Published var goToAddNewWatchlistScreen: Bool = false {
        didSet {
            if goToAddNewWatchlistScreen == false {
                addNewWatchlistViewModel = nil
            }
        }
    }
    
    @Published var goToWatchlistScreen: Bool = false {
        didSet {
            if goToWatchlistScreen == false {
                watchlistViewModel = nil
            }
        }
    }
    
    @Published var goToAddNewSymbolScreen: Bool = false {
        didSet {
            if goToAddNewSymbolScreen == false {
                addNewSymbolViewModel = nil
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
    
    @Published var watchlistsViewModel: WatchlistsViewModel? {
        didSet {
            if watchlistsViewModel != nil {
                currentViewModel = watchlistsViewModel
            } else {
                currentViewModel = nil
            }
        }
    }
    
    @Published var addNewWatchlistViewModel: AddNewWatchlistViewModel? {
        didSet {
            if addNewWatchlistViewModel != nil {
                currentViewModel = addNewWatchlistViewModel
            } else {
                currentViewModel = watchlistsViewModel
            }
        }
    }
    
    @Published var watchlistViewModel: WatchlistViewModel? {
        didSet {
            if watchlistViewModel != nil {
                currentViewModel = watchlistViewModel
            } else {
                currentViewModel = watchlistsViewModel
            }
        }
    }
    
    @Published var addNewSymbolViewModel: AddNewSymbolViewModel? {
        didSet {
            if addNewSymbolViewModel != nil {
                currentViewModel = addNewSymbolViewModel
            } else {
                currentViewModel = watchlistViewModel
            }
        }
    }
    
    @Published var quoteViewModel: QuoteViewModel?{
        didSet {
            if quoteViewModel != nil {
                currentViewModel = quoteViewModel
            } else {
                currentViewModel = watchlistViewModel
            }
        }
    }
    
    private var appFirstStartProvider: AppFirstStartProviding!
    private var watchlistsProvider: WatchlistsProviding!
    private var quotesProvider: QuotesProviding!
    private var symbolsProvider: SymbolsProviding!
    private var chartDataProvider: ChartDataProviding!
    
    private var currentViewModel: Any?
    
    init() {}
    
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
        // todo: add same setup as in UIKit app later on
        self.watchlistsViewModel = WatchlistsViewModel(
            coordinator: self,
            watchlistsProvider: self.watchlistsProvider
        )
        self.goToWatchlistsScreen = true
    }
    
    func execute(action: Action) {
        if currentViewModel is WatchlistsViewModel {
            switch action {
            case .itemSelected(let data):
                if let watchlist = data as? Watchlist {
                    self.watchlistViewModel = WatchlistViewModel(
                        coordinator: self,
                        watchlistsProvider: self.watchlistsProvider,
                        quotesProvider: self.quotesProvider,
                        watchlist: watchlist,
                        refreshRate: 5
                    )
                    self.goToWatchlistScreen = true
                }
            case .addButtonTapped:
                self.addNewWatchlistViewModel = AddNewWatchlistViewModel(
                    coordinator: self,
                    watchlistsProvider: self.watchlistsProvider
                )
                self.goToAddNewWatchlistScreen = true
            default:
                return
            }
        } else if currentViewModel is WatchlistViewModel {
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
            case .addButtonTapped(let data):
                if let watchlist = data as? Watchlist {
                    self.addNewSymbolViewModel = AddNewSymbolViewModel(
                        coordinator: self,
                        watchlistsProvider: self.watchlistsProvider,
                        symbolsProvider: self.symbolsProvider,
                        watchlist: watchlist,
                        searchTextDebounceMillis: 500
                    )
                    self.goToAddNewSymbolScreen = true
                }
            default:
                return
            }
        } else if currentViewModel is AddNewWatchlistViewModel {
            switch action {
            case .inputSubmitted:
                self.goToAddNewWatchlistScreen = false
            default:
                return
            }
        }
    }
}
