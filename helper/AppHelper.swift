import UIKit

class AppHelper {
    static let shared = AppHelper()

    private init() {}

    // Method to display an alert with the given message
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        // Assuming we have a root view controller to present the alert
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(alert, animated: true, completion: nil)
        }
    }

    // Method to generate labels with given texts and colors, or use defaults if empty
    func generateViews(withTexts texts: [String] = [], colors: [UIColor] = []) -> [UIView] {
        // Default texts and colors if not provided
        let defaultTexts = ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5", "Label 6", "Label 7", "Label 8", "Label 9", "Label 10"]
        let defaultColors: [UIColor] = [UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"), UIColor(hex: "#d33086"),
                                        UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"), UIColor(hex: "#d33086"),
                                        UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"), UIColor(hex: "#d33086"),
                                        UIColor(hex: "#0d8363")]

        // Use default values if parameters are empty
        let labelTexts = texts.isEmpty ? defaultTexts : texts
        let labelColors = colors.isEmpty ? defaultColors : colors

        // Generate labels
        let labels = labelTexts.enumerated().map { index, text in
            let label = MyUILabel()
            label.text = text
            label.backgroundColor = labelColors[index % labelColors.count]
            label.textAlignment = .center
            label.layer.cornerRadius = 8.0
            label.layer.masksToBounds = true
            
            // Set the height using SnapKit
            label.snp.makeConstraints { make in
                make.height.equalTo(index % 2 == 0 ? 100 : 64)
            }
            return label
        }

        return labels
    }
}
