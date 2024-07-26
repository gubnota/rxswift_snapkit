import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xff0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xff00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    // Convert UIColor to hex string
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgb: Int = (Int(red * 255) << 16) | (Int(green * 255) << 8) | Int(blue * 255)
        
        return String(format: "#%06x", rgb)
    }
}
