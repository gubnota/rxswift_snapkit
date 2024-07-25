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
}
