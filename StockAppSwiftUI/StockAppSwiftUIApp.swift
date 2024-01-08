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
        }
    }
}
