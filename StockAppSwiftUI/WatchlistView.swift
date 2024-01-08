//
//  WatchlistView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

struct WatchlistView: View {
    @ObservedObject var viewModel: WatchlistViewModel
    
    // todo: this could be shared accross UIKit and SwiftUI project - as well as styles of Views (another package?)
    private static let horizontalPadding: CGFloat = 20.0
    private static let errorTextPaddingTop: CGFloat = 15.0
    
    var body: some View {
        Group {
            if viewModel.state == .loading {
                ProgressView()
            } else if viewModel.state == .error {
                Text(viewModel.error ?? "") // todo: style same as in UIKit app
                    .padding(.top, Self.errorTextPaddingTop)
                    .padding(.horizontal, Self.horizontalPadding)
            } else if viewModel.state == .dataObtained {
                List {
                    ForEach(viewModel.stockItems, id: \.symbol) { item in
                        WatchlistCellView(item: item, action: {})
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: viewModel.onViewWillAppear)
        .onDisappear(perform: viewModel.onViewWillDisappear)
    }
}

