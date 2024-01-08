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
    
    private static let leftPadding: CGFloat = 20.0
    private static let rightPadding: CGFloat = Self.leftPadding + 20.0
    private static let labelWidth: CGFloat = (UIScreen.main.bounds.width - Self.leftPadding - Self.rightPadding) / 4
    
    var body: some View {
        Button(
            action: action,
            label: {
                HStack() { // todo: use constant like in UIKit
                    Text(item.symbol)
                        .frame(width: Self.labelWidth)
                    Text(item.quote?.bidPrice.to2DecPlaces() ?? "-")
                        .frame(width: Self.labelWidth)
                    Text(item.quote?.askPrice.to2DecPlaces() ?? "-")
                        .frame(width: Self.labelWidth)
                    Text(item.quote?.lastPrice.to2DecPlaces() ?? "-")
                        .frame(width: Self.labelWidth)
                    // todo: add > on the right - maybe to the list not here...
                }
                .multilineTextAlignment(.leading)
                .padding(.leading, Self.leftPadding)
                .padding(.trailing, Self.rightPadding)
            }
        )
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
