//
//  WatchlistsCellView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic

struct WatchlistsCellView: View {
    var watchlist: Watchlist
    var action: () -> Void
    
    private static let fontSize: CGFloat = 16.0
    
    var body: some View {
        Button(
            action: action,
            label: {
                HStack {
                    Text(watchlist.name)
                        .font(.system(size: Self.fontSize))
                    Spacer()
                    Chevron()
                }
                .background(in: Rectangle())
            }
        )
        .buttonStyle(.plain)
    }
}

struct WatchlistsCellView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistsCellView(
            watchlist: Watchlist(id: UUID(), name: "My list", symbols: ["AAPL"]),
            action: {}
        )
    }
}
