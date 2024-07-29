import UIKit

class CandleView: UIView {
    
    var klineView: OKKLineView!
    var dataEntries: [CandleDataEntry] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        klineView = OKKLineView(frame: self.bounds)
        klineView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(klineView)
    }
    
    func setData(from data: CandleDataArray) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let dataEntries = data.candles.data.map { candleData in
                return CandleDataEntry(open: candleData.open,
                                       close: candleData.close,
                                       high: candleData.high,
                                       low: candleData.low,
                                       date: candleData.date,
                                       volume: candleData.volume)
            }
            self.dataEntries = dataEntries
            self.klineView.drawKLineView(klineModels: dataEntries.map {
                OKKLineModel(date: $0.date.timeIntervalSince1970,
                             open: $0.open,
                             close: $0.close,
                             high: $0.high,
                             low: $0.low,
                             volume: $0.volume)
            })
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CandleView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = CandleView()
            // Assuming this is placed inside a function or appropriate context in your code

            if let url = Bundle.main.url(forResource: "sber_sample", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    print("Raw Data: \(data)") // This prints the raw data for debugging
                    
                    // Convert raw data to string for a readable format
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON String: \(jsonString)")
                    }
                    
                    // Decode the JSON data into your model structure for verification
                    let decoder = JSONDecoder()
                    let candleDataArray = try decoder.decode(CandleDataArray.self, from: data)
                    
                    // Use the parsed data for any debugging or verification if needed
                    print("Parsed Data: \(candleDataArray)")

                    // Pass the raw JSON data to your view
                    view.setData(from: candleDataArray )
                } catch {
                    print("Failed to load or parse JSON: \(error)")
                }
            } else {
                print("JSON file not found.")
            }
            
            return view
        }
        .previewLayout(.sizeThatFits)
        .frame(width: 400, height: 300)
        .padding()
    }
}
#endif
