//
//  Chevron.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 10/01/2024.
//

import SwiftUI

struct Chevron: View {
    static let width: CGFloat = 20.0
    
    var body: some View {
        Image(systemName: "chevron.right")
            .frame(width: Self.width)
            .foregroundColor(.gray.opacity(0.5))
    }
}

struct Chevron_Previews: PreviewProvider {
    static var previews: some View {
        Chevron()
    }
}
