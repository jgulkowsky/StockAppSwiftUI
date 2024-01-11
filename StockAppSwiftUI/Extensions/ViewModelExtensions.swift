//
//  ViewModelExtensions.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 12/01/2024.
//

import StockAppLogicSwiftUI

extension WatchlistsViewModel: Hashable {
    public static func == (lhs: StockAppLogicSwiftUI.WatchlistsViewModel, rhs: StockAppLogicSwiftUI.WatchlistsViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension WatchlistViewModel: Hashable {
    public static func == (lhs: StockAppLogicSwiftUI.WatchlistViewModel, rhs: StockAppLogicSwiftUI.WatchlistViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension AddNewWatchlistViewModel: Hashable {
    public static func == (lhs: StockAppLogicSwiftUI.AddNewWatchlistViewModel, rhs: StockAppLogicSwiftUI.AddNewWatchlistViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension AddNewSymbolViewModel: Hashable {
    public static func == (lhs: StockAppLogicSwiftUI.AddNewSymbolViewModel, rhs: StockAppLogicSwiftUI.AddNewSymbolViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension QuoteViewModel: Hashable {
    public static func == (lhs: StockAppLogicSwiftUI.QuoteViewModel, rhs: StockAppLogicSwiftUI.QuoteViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
