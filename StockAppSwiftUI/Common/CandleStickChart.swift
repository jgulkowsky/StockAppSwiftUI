//
//  CandleStickChart.swift
//  StockAppSwiftUI
//
//  Created by Jan Gulkowski on 08/01/2024.
//

import SwiftUI
import DGCharts
import StockAppLogic

// todo: as generally 95% of this struct is a copy from UIKit app - it would be nice to have some StockAppUI package with shared UIViews and here we would just use the CandleStickChartView from the package to create it's SwiftUI version

typealias ChartData = StockAppLogic.ChartData

struct CandleStickChart: UIViewRepresentable {
    @Binding var data: ChartData
    
    func makeUIView(context: Context) -> CandleStickChartView {
        let chart = createCandleStickChartView()
        chart.data = getData(basedOn: data)
        return chart
    }
    
    func updateUIView(_ uiView: CandleStickChartView, context: Context) {
        uiView.data = getData(basedOn: data)
    }
    
    typealias UIViewType = CandleStickChartView
}

private extension CandleStickChart {
    func createCandleStickChartView() -> CandleStickChartView {
        class XAxisValueFormatter: AxisValueFormatter {
            lazy private var dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale.current
                dateFormatter.dateFormat = "dd/MM"
                return dateFormatter
            }()
            
            func stringForValue(_ value: Double, axis: AxisBase?) -> String {
                let daysToDate = value
                let date = getDate(outFrom: daysToDate)
                return dateFormatter.string(from: date)
            }
            
            // this method is thightly combined with func getDaysFromNow(to date: Date) -> Double - don't change one without the second one
            private func getDate(outFrom daysToDate: Double) -> Date {
                let secondsToDate = 3600 * 24 * daysToDate
                let date = Date().addingTimeInterval(secondsToDate)
                return date
                // as we mapped $0.date.timeIntervalSince1970 into daysToDate - now it is time to revert this process and then get Date out of timeIntervalSince1970
            }
        }
        
        let chartView = CandleStickChartView()
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.valueFormatter = XAxisValueFormatter()
        chartView.legend.enabled = false
        chartView.setScaleEnabled(false)
        return chartView
    }
    
    func getData(basedOn chartData: ChartData) -> CandleChartData {
        let entries = chartData.values.map {
            return CandleChartDataEntry(
                x: getDaysFromNow(to: $0.date),
                shadowH: $0.high,
                shadowL: $0.low,
                open: $0.open,
                close: $0.close)
        }
        let set = CandleChartDataSet(entries: entries, label: "")
        set.barSpace = 0.1
        set.drawValuesEnabled = false
        set.highlightEnabled = false
        let data = CandleChartData(dataSet: set)
        return data
    }
    
    // this method is thighlty combined with func getDate(outFrom daysToDate: Double) -> Date - don't change one without the second one
    func getDaysFromNow(to date: Date) -> Double {
        let daysToDate = Date().distance(to: date) / (3600 * 24)
        return daysToDate
        // we need to use daysToDate mapping because when passing $0.date.timeIntervalSince1970 it is too big and the candle sticks are too small - it's a known bug in DGCharts
    }
}
