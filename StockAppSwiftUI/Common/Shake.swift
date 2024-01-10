//
//  Shake.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 09/01/2024.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 5
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translationX = amount * sin(animatableData * .pi * CGFloat(shakesPerUnit))
        return ProjectionTransform(
            CGAffineTransform(translationX: translationX, y: 0)
        )
    }
}
