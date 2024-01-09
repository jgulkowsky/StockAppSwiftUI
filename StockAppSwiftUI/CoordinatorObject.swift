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
    
    @Published var watchlistViewModel: WatchlistViewModel?{
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
