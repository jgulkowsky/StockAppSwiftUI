//
//  CoordinatorView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI

struct CoordinatorView: View {
    @ObservedObject var coordinator: CoordinatorObject
    
    var body: some View {
        NavigationStack {
            if let quoteViewModel = coordinator.quoteViewModel {
                QuoteView(viewModel: quoteViewModel)
            }
        }
    }
}