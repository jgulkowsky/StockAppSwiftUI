//
//  WatchlistHeaderView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI

struct WatchlistHeaderView: View {
    var items: [String]
    
    private static let fontSize: CGFloat = 10.0
    
    var body: some View {
        HStack() {
            Text(items[0])
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(items[1])
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(items[2])
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(items[3])
                .frame(maxWidth: .infinity, alignment: .leading)
            Color.clear.frame(width: Chevron.width)
        }
        .font(.system(size: Self.fontSize))
    }
}

struct WatchlistHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistHeaderView(items: ["0", "1", "2", "3"])
    }
}
