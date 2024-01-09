//
//  ErrorView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 10/01/2024.
//

import SwiftUI

struct ErrorView: View {
    var text: String
    
    var buttonText: String?
    var onTap: (() -> Void)?
    
    // todo: this could be shared accross UIKit and SwiftUI project - as well as styles of Views (another package?)
    private static let horizontalPadding: CGFloat = 20.0
    private static let errorTextPaddingTop: CGFloat = 15.0
    private static let errorButtonPaddingTop: CGFloat = 30.0
    private static let errorButtonWidth: CGFloat = 150.0
    private static let errorButtonHeight: CGFloat = 40.0
    
    var body: some View {
        VStack {
            Text(text)
                .foregroundColor(.red)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.top, Self.errorTextPaddingTop)
                .padding(.horizontal, Self.horizontalPadding)
            
            if let buttonText = buttonText,
               let onTap = onTap {
                Button { // todo: make it solid
                    onTap()
                } label: {
                    Text(buttonText)
                }
                .padding(.top, Self.errorButtonPaddingTop)
                .frame(
                    width: Self.errorButtonWidth,
                    height: Self.errorButtonHeight
                )
            }
            
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(text: "Some error!")
    }
}
