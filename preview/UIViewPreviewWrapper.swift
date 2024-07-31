#if canImport(SwiftUI) && DEBUG
import SwiftUI
// This struct is used to wrap a UIView and provide a SwiftUI preview
@available(iOS 13.0, *)
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    // Initializer to accept a UIView instance
    init(_ builder: @escaping () -> View) {
        self.view = builder()
    }

    // Create the UIView instance to be used in the SwiftUI view hierarchy
    func makeUIView(context: Context) -> View {
        return view
    }

    // Update the UIView instance as needed (e.g., when state changes)
    func updateUIView(_ uiView: View, context: Context) {
        // Update the view if necessary
    }
}
#endif
// enable preview for UIKit
// source: https://fluffy.es/xcode-previews-uikit/
#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
}

// make it possible to toPreview {vs in ... }
// UIViewController extension to add a preview method

@available(iOS 13.0, *)
extension UIViewController {
    func toPreview(onLoad: ((UIViewController) -> Void)? = nil) -> some View {
        UIViewControllerPreview(viewController: self, onLoad: onLoad)
    }
}
@available(iOS 13.0, *)
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    let onLoad: ((ViewController) -> Void)?

    func makeUIViewController(context: Context) -> ViewController {
        if let onLoad = onLoad {
            DispatchQueue.main.async {
                onLoad(viewController)
            }
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

#endif
