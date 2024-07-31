#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview{BaseView()}
            .previewLayout(.sizeThatFits)//.fixed(width: 300, height: 400))
    }
}

#endif

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            ButtonView(label: "Click me") {
                    AppHelper.shared.showAlert(title: "Button", message: "Text: button clicked!")
            }
        }
        .previewLayout(.sizeThatFits)
        .frame(width: 300, height: 88) // Set desired preview size
        .padding()
    }
}
#endif
