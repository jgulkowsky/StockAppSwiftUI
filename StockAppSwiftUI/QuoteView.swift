//
//  QuoteView.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import StockAppLogic
import StockAppLogicSwiftUI

struct QuoteView: View {
    @ObservedObject var viewModel: QuoteViewModel
    
    var body: some View {
        Group {
            if viewModel.state == .loading {
                ProgressView()
            } else if viewModel.state == .error {
                VStack {
                    Text(viewModel.error ?? "")
                    Button {
                        viewModel.onErrorRefreshButtonTapped()
                    } label: {
                        Text("Refresh")
                    }
                }
                Spacer()
            } else if viewModel.state == .dataObtained {
                VStack {
                    // todo: add chart view
                    Spacer()
                    VStack { // todo: or HStack if there's enough space - when traitCollection.horizontalSizeClass == .regular
                        HStack {
                            Text("\(viewModel.bidPrice)")
                            Spacer()
                        }
                        
                        HStack {
                            Text("\(viewModel.askPrice)")
                            Spacer()
                        }
                        
                        HStack {
                            Text("\(viewModel.lastPrice)")
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear(perform: viewModel.onViewWillAppear)
        .onDisappear(perform: viewModel.onViewWillDisappear)
    }
}

// todo: add mocks so we can actually see the QuoteView
struct QuoteView_Previews: PreviewProvider {
    static let apiFetcher = ApiFetcher()
    
    static var previews: some View {
        QuoteView(
            viewModel: QuoteViewModel(
                coordinator: CoordinatorObject(),
                quotesProvider: QuotesProvider(apiFetcher: apiFetcher),
                chartDataProvider: ChartDataProvider(apiFetcher: apiFetcher),
                symbol: "AAPL",
                refreshRate: 5
            )
        )
    }
}
