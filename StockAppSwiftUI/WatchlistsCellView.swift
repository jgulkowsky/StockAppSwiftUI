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
    
    private static let leftPadding: CGFloat = 20.0
    private static let rightPadding: CGFloat = Self.leftPadding + 20.0
    
    private static let fontSize: CGFloat = 16.0
    
    var body: some View {
        Button(
            action: action,
            label: {
                Text(watchlist.name)
                    .font(.system(size: Self.fontSize, weight: .bold))
                    .background(in: Rectangle())
                    .multilineTextAlignment(.leading)
                    .padding(.leading, Self.leftPadding)
                    .padding(.trailing, Self.rightPadding)
                    .background(.red)
                    // todo: add > on the right - maybe to the list not here...
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
