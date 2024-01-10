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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // todo: this could be shared accross UIKit and SwiftUI project - as well as styles of Views (another package?)
    private static let labelsPaddingTop: Double = 20
    private static let offsetBetweenLabels: Double = 5
    private static let labelsPaddingBottom: Double = 15
    
    var body: some View {
        Group {
            if viewModel.state == .loading {
                ProgressView()
            } else if viewModel.state == .error {
                ErrorView(
                    text: viewModel.error ?? "",
                    buttonText: "Refresh",
                    onTap: viewModel.onErrorRefreshButtonTapped
                )
                .padding(.horizontal, Self.horizontalPadding)
            } else if viewModel.state == .dataObtained {
                VStack {
                    CandleStickChart(data: $viewModel.chartData)
                    
                    Group {
                        if horizontalSizeClass == .compact {
                            VStack(spacing: Self.offsetBetweenLabels) {
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
                        } else {
                            HStack {
                                Text("\(viewModel.bidPrice)")
                                    .frame(maxWidth: .infinity)
                                Text("\(viewModel.askPrice)")
                                    .frame(maxWidth: .infinity)
                                Text("\(viewModel.lastPrice)")
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(.top, Self.labelsPaddingTop)
                    .padding(.bottom, Self.labelsPaddingBottom)
                    
                }
                .padding(.horizontal, Self.horizontalPadding)
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: viewModel.onViewWillAppear)
        .onDisappear(perform: viewModel.onViewWillDisappear)
    }
}
