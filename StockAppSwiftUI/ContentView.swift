//
//  ContentView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var coordinator: CoordinatorObject
    
    var body: some View {
        CoordinatorView(
            coordinator: coordinator
        )
    }
}
