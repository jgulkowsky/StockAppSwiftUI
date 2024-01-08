//
//  MockWatchlistsCoreDataProvider.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import Foundation
import StockAppLogic

// todo: just for now we have mock - later on remove it and create or copy the model and use it with real provider - best would be to somehow add the model into the StockAppLogic (but it didn't want to work initially so probably this will create some problems)
class MockWatchlistsCoreDataProvider: WatchlistsCoreDataProviding {
    private static let watchlistsToReturn = [
        Watchlist(id: UUID(), name: "My First List", symbols: ["AAPL", "GOOG", "MSFT"]),
        Watchlist(id: UUID(), name: "My Second List", symbols: ["AAPL", "MSFT"]),
        Watchlist(id: UUID(), name: "My Third List", symbols: []),
    ]
    
    func getWatchlists() -> [Watchlist] {
        return Self.watchlistsToReturn
    }
    
    func addWatchlist(_ watchlist: Watchlist) {}
    
    func addSymbolToWatchlist(_ symbol: String, _ watchlist: Watchlist) {}
    
    func removeSymbolFromWatchlist(_ symbol: String, _ watchlist: Watchlist) {}
    
    func deleteWatchlist(_ watchlist: Watchlist) {}
}
