
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct MyRowView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            // Create views for the row
 
            // Create views for the row
            let views = AppHelper.shared.generateViews(withTexts: ["Label 1", "Label 2", "Label 3"],colors: [UIColor(hex: "#630d83"), UIColor(hex: "#d33086"),
                                                                                                             UIColor(hex: "#0d8363")])

            let rowView = MyRowView(views: views, spacing: 10, padding: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)) { index in
                    AppHelper.shared.showAlert(title: "Tapped at \(index)", message: "Text: tapped at ID: \(index)")

            }
            rowView.backgroundColor = .lightGray
            return rowView
        }
        .frame(height: 80)
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
