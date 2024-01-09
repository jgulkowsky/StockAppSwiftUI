//
//  ErrorText.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 10/01/2024.
//

import SwiftUI

struct ErrorText: View {
    var text: String
    
    // todo: this could be shared accross UIKit and SwiftUI project - as well as styles of Views (another package?)
    private static let horizontalPadding: CGFloat = 20.0
    private static let errorTextPaddingTop: CGFloat = 15.0
    
    var body: some View {
        Text(text)
            .foregroundColor(.red)
            .frame(alignment: .center)
            .padding(.top, Self.errorTextPaddingTop)
            .padding(.horizontal, Self.horizontalPadding)
    }
}

struct ErrorText_Previews: PreviewProvider {
    static var previews: some View {
        ErrorText(text: "Some error!")
    }
}
