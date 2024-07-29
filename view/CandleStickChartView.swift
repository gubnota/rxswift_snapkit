//
//  CandleStickChartView.swift
//  rxswift_snapkit
//
//  Created by Vladislav Muravyev on 29.07.2024.
//

import UIKit


class CandleStickChartView: BaseView {
    var dataEntries: [CandleDataEntry] = []
    
    private var candleWidth: CGFloat {
        return bounds.width / CGFloat(dataEntries.count) * 0.7
    }
    private var spaceBetweenCandles: CGFloat {
        return bounds.width / CGFloat(dataEntries.count) * 0.3
    }

    override func draw(_ rect: CGRect) {
        guard !dataEntries.isEmpty else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let chartHeight = bounds.height
        let maxYValue = dataEntries.map { $0.high }.max() ?? 0
        let minYValue = dataEntries.map { $0.low }.min() ?? 0
        
        let scaleY = chartHeight / CGFloat(maxYValue - minYValue)
        
        for (index, entry) in dataEntries.enumerated() {
            let xPosition = CGFloat(index) * (candleWidth + spaceBetweenCandles)
            let highY = CGFloat(maxYValue - entry.high) * scaleY
            let lowY = CGFloat(maxYValue - entry.low) * scaleY
            let openY = CGFloat(maxYValue - entry.open) * scaleY
            let closeY = CGFloat(maxYValue - entry.close) * scaleY
            
            let color: UIColor = entry.close >= entry.open ? UIColor(hex: "#006633") : UIColor(hex: "#dd0044")
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(1.0)
            
            // Draw the wick (high-low line)
            context.move(to: CGPoint(x: xPosition + candleWidth / 2, y: highY))
            context.addLine(to: CGPoint(x: xPosition + candleWidth / 2, y: lowY))
            context.strokePath()
            
            // Draw the body
            context.setFillColor(color.cgColor)
            let bodyRect = CGRect(x: xPosition, y: min(openY, closeY), width: candleWidth, height: abs(openY - closeY))
            context.fill(bodyRect)
        }
    }

    func setData(_ entries: [CandleDataEntry]) {
        self.dataEntries = entries
        setNeedsDisplay()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CandlestickChartView_Previews: PreviewProvider {
    static func loadDataFromJSON() -> [CandleDataEntry] {
        if let path = Bundle.main.path(forResource: "sber_sample", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let candleDataArray = try? JSONDecoder().decode(CandleDataArray.self, from: data) {
            
            return candleDataArray.candles.data.map {
                CandleDataEntry(open: $0.open, close: $0.close, high: $0.high, low: $0.low, date: $0.date)
            }
        }
        return []
    }

    static var previews: some View {
        UIViewPreview {
            let view = CandleStickChartView()
            
            // Load data from moex_sample.json
            if let path = Bundle.main.path(forResource: "sber_sample", ofType: "json"),
               let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
               let candleDataArray = try? JSONDecoder().decode(CandleDataArray.self, from: data) {
                
                let candlesticks = loadDataFromJSON() // Load data from the JSON file
                view.setData(candlesticks)
            }
            
            return view
        }
        .previewLayout(.sizeThatFits)
        .frame(width: 300, height: 150)
        .padding()
    }
}
#endif
