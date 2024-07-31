#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let views = AppHelper.shared.generateViews(
                withTexts: ["Label 1", "Label 2", "Label 3"],
                colors: [UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"), UIColor(hex: "#d33086")]
            )
            let sv = VerticalView(
                views: views,
                gap: 15,
                leadingOffset: 10,
                trailingOffset: 10,
                verticalAlignment: .bottom,
                verticalOffset: 20
            ) { index, info in
                AppHelper.shared.showAlert(title: "Tapped at \(index)", message: "Info: \(info)")
            }
            sv.backgroundColor = UIColor(hex: "f1f9f0")
            sv.setRoundedCorners(radius: 28.0)
            return sv
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
