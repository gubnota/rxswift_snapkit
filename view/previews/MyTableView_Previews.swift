
#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct MyTableView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            // Create labels with rounded corners using a closure
            let labelTexts = ["Label 1", "Label 2", "Label 3","Label 1", "Label 2", "Label 3","Label 1", "Label 2", "Label 3","Label 1"]
            let labelColors: [UIColor] = [UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363")]
            let labels: [MyUILabel] = labelTexts.enumerated().map { index, text in
                let label = MyUILabel(customHeight: index%2==0 ? 100.0 : 64.0)
                label.text = text
                label.backgroundColor = labelColors[index]
                label.textAlignment = .center
                label.layer.cornerRadius = 8.0
                label.layer.masksToBounds = true
                return label
            }

            let sv = MyTableView(customLabels: labels) { selectedText, index in
                // Display an alert with the selected text and index
                let alert = UIAlertController(title: "Label Selected", message: "Text: \(selectedText)\nID: \(index)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                // Assuming we have a root view controller to present the alert
                if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                    rootVC.present(alert, animated: true, completion: nil)
                }
            }
            sv.backgroundColor = UIColor(hex: "f1f9f0")
            sv.layer.cornerRadius = 28.0
            sv.layer.masksToBounds = true
            return sv
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
