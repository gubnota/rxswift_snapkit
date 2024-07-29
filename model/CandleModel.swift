import Foundation

struct CandleDataEntry {
    var open: Double
    var close: Double
    var high: Double
    var low: Double
    var date: Date
    var volume: Double // Add volume property
}

struct CandleDataArray: Codable {
    var candles: Candles
}

struct Candles: Codable {
    var metadata: Metadata
    var columns: [String]
    var data: [CandleDataEntry]
}

struct Metadata: Codable {
    var open: TypeInfo
    var close: TypeInfo
    var high: TypeInfo
    var low: TypeInfo
    var value: TypeInfo
    var volume: TypeInfo
    var begin: DateTimeInfo
    var end: DateTimeInfo
}

struct TypeInfo: Codable {
    var type: String
}

struct DateTimeInfo: Codable {
    var type: String
    var bytes: Int
    var max_size: Int
}

extension Candles {
    enum CodingKeys: String, CodingKey {
        case metadata, columns, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        metadata = try container.decode(Metadata.self, forKey: .metadata)
        columns = try container.decode([String].self, forKey: .columns)
        
        var dataContainer = try container.nestedUnkeyedContainer(forKey: .data)
        var entries = [CandleDataEntry]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        while !dataContainer.isAtEnd {
            var nestedContainer = try dataContainer.nestedUnkeyedContainer()
            let open = try nestedContainer.decode(Double.self)
            let close = try nestedContainer.decode(Double.self)
            let high = try nestedContainer.decode(Double.self)
            let low = try nestedContainer.decode(Double.self)
            _ = try nestedContainer.decode(Double.self) // Skip value
            let volume = try nestedContainer.decode(Double.self) // Decode volume
            let beginString = try nestedContainer.decode(String.self)
            _ = try nestedContainer.decode(String.self) // Skip end
            
            guard let date = dateFormatter.date(from: beginString) else {
                continue
            }
            
            let entry = CandleDataEntry(open: open, close: close, high: high, low: low, date: date, volume: volume)
            entries.append(entry)
        }
        
        self.data = entries
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(metadata, forKey: .metadata)
        try container.encode(columns, forKey: .columns)
        
        var dataContainer = container.nestedUnkeyedContainer(forKey: .data)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        for entry in data {
            var nestedContainer = dataContainer.nestedUnkeyedContainer()
            try nestedContainer.encode(entry.open)
            try nestedContainer.encode(entry.close)
            try nestedContainer.encode(entry.high)
            try nestedContainer.encode(entry.low)
            try nestedContainer.encode(0.0) // Placeholder for value
            try nestedContainer.encode(entry.volume) // Encode volume
            let dateString = dateFormatter.string(from: entry.date)
            try nestedContainer.encode(dateString)
            try nestedContainer.encode(dateString) // Placeholder for end date, use actual if available
        }
    }
}
