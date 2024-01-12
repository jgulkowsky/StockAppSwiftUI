//
//  WatchlistCellView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic

struct WatchlistCellView: View {
    var item: StockItem
    var action: () -> Void
    
    private static let fontSize: CGFloat = 16.0
    
    var body: some View {
        Button(
            action: action,
            label: {
                HStack() {
                    Text(item.symbol)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: Self.fontSize, weight: .bold))
                    Text(item.quote?.bidPrice.to2DecPlaces() ?? "-")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(item.quote?.askPrice.to2DecPlaces() ?? "-")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(item.quote?.lastPrice.to2DecPlaces() ?? "-")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Chevron()
                }
                .background(in: Rectangle())
                .font(.system(size: Self.fontSize))
            }
        )
        .buttonStyle(.plain)
    }
}

struct WatchlistCellView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistCellView(
            item: StockItem(
                symbol: "AAPL",
                quote: Quote(
                    date: Date(),
                    bidPrice: 111.11111,
                    askPrice: 113.13333,
                    lastPrice: 115.15555
                )
            ),
            action: {}
        )
        
        WatchlistCellView(
            item: StockItem(
                symbol: "AAPL",
                quote: nil
            ),
            action: {}
        )
    }
}
