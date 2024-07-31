
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct MyScrollableStackView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let views = AppHelper.shared.generateViews()
            let stackView = MyScrollableStackView(views: views, isHorizontal: false) { selectedText, index in
                AppHelper.shared.showAlert(title: "Tapped at \(index)", message: "Text: \(selectedText)\nID: \(index)")
            }
//            stackView.backgroundColor = .clear// UIColor(hex: "f1f9f0")
            return stackView
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
