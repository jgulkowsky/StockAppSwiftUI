//
//  StockAppSwiftUIApp.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

typealias QuoteViewModel = StockAppLogicSwiftUI.QuoteViewModel // todo: maybe such typealiasing could be in StockAppLogicSwiftUI so we don't have to write it here?

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
