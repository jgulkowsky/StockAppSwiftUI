//
//  WatchlistHeaderView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI

struct WatchlistHeaderView: View {
    var items: [String]
    
    // todo: same as in WachlistCellView - so either put this into common package accross the projects or here in this project put it into one place
    private static let leftPadding: CGFloat = 20.0
    private static let rightPadding: CGFloat = Self.leftPadding + 20.0
    private static let labelWidth: CGFloat = (UIScreen.main.bounds.width - Self.leftPadding - Self.rightPadding) / 4
    
    private static let fontSize: CGFloat = 10.0
    
    var body: some View {
        HStack() {
            Text(items[0])
                .frame(width: Self.labelWidth)
            Text(items[1])
                .frame(width: Self.labelWidth)
            Text(items[2])
                .frame(width: Self.labelWidth)
            Text(items[3])
                .frame(width: Self.labelWidth)
        }
        .multilineTextAlignment(.leading)
        .font(.system(size: Self.fontSize))
        .padding(.leading, Self.leftPadding)
        .padding(.trailing, Self.rightPadding)
    }
}

struct WatchlistHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistHeaderView(items: ["0", "1", "2", "3"])
    }
}
