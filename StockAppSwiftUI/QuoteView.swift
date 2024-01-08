//
//  QuoteView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogicSwiftUI

struct QuoteView: View {
    @ObservedObject var viewModel: QuoteViewModel
    
    var body: some View {
        Text("It's quote screen :)")
    }
}

// todo: implement this later on
//struct QuoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteView(viewModel: QuoteViewModel(
//            coordinator: <#T##Coordinator#>,
//            quotesProvider: <#T##QuotesProviding#>,
//            chartDataProvider: <#T##ChartDataProviding#>,
//            symbol: <#T##String#>,
//            refreshRate: <#T##Double#>
//        )
//    }
//}
