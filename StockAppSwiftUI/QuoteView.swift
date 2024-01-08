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
    
    // todo: this could be shared accross UIKit and SwiftUI project - as well as styles of Views (another package?)
    private static let horizontalPadding: CGFloat = 20.0
    private static let errorTextPaddingTop: CGFloat = 15.0
    private static let errorButtonPaddingTop: CGFloat = 30.0
    private static let errorButtonWidth: CGFloat = 150.0
    private static let errorButtonHeight: CGFloat = 40.0
    private static let labelsPaddingTop: Double = 20
    private static let offsetBetweenLabels: Double = 5
    private static let labelsPaddingBottom: Double = 15
    
    var body: some View {
        Group {
            if viewModel.state == .loading {
                ProgressView()
            } else if viewModel.state == .error {
                VStack {
                    Text(viewModel.error ?? "") // todo: style same as in UIKit app
                        .padding(.top, Self.errorTextPaddingTop)
                    Button { // todo: make it solid
                        viewModel.onErrorRefreshButtonTapped()
                    } label: {
                        Text("Refresh")
                    }
                    .padding(.top, Self.errorButtonPaddingTop)
                    .frame(
                        width: Self.errorButtonWidth,
                        height: Self.errorButtonHeight
                    )
                }
                .padding(.horizontal, Self.horizontalPadding)
                
                Spacer()
            } else if viewModel.state == .dataObtained {
                VStack {
                    CandleStickChart(data: $viewModel.chartData)
                        .padding(.horizontal, Self.horizontalPadding)
                    VStack(spacing: Self.offsetBetweenLabels) { // todo: or HStack if there's enough space - when traitCollection.horizontalSizeClass == .regular
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
                    .padding(.horizontal, Self.horizontalPadding)
                    .padding(.top, Self.labelsPaddingTop)
                    .padding(.bottom, Self.labelsPaddingBottom)
                }
            }
        }
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
