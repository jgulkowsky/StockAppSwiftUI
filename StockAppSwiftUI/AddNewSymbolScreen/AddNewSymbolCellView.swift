//
//  AddNewSymbolCellView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 09/01/2024.
//

import SwiftUI
import StockAppLogic

struct AddNewSymbolCellView: View {
    var symbol: String
    var action: () -> Void
    
    private static let fontSize: CGFloat = 16.0
    
    var body: some View {
        Button(
            action: action,
            label: {
                HStack {
                    Text(symbol)
                        .font(.system(size: Self.fontSize))
                    Spacer()
                }
                .background(in: Rectangle())
            }
        )
        .buttonStyle(.plain)
    }
}

struct SymbolCellView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewSymbolCellView(
            symbol: "AAPL",
            action: {}
        )
    }
}
