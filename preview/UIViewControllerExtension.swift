//// enable preview for UIKit
//// source: https://fluffy.es/xcode-previews-uikit/
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//@available(iOS 13.0, *)
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        // this variable is used for injecting the current view controller
//        let viewController: UIViewController
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//    func toPreview() -> some View {
//        // inject self (the current view controller) for the preview
//        Preview(viewController: self).edgesIgnoringSafeArea(.all)
//    }
//}
//
//// make it possible to toPreview {vs in ... }
//// UIViewController extension to add a preview method
//
//@available(iOS 13.0, *)
//extension UIViewController {
//    func toPreview(onLoad: ((UIViewController) -> Void)? = nil) -> some View {
//        UIViewControllerPreview(viewController: self, onLoad: onLoad)
//    }
//}
//@available(iOS 13.0, *)
//struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
//    let viewController: ViewController
//    let onLoad: ((ViewController) -> Void)?
//
//    func makeUIViewController(context: Context) -> ViewController {
//        if let onLoad = onLoad {
//            DispatchQueue.main.async {
//                onLoad(viewController)
//            }
//        }
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
//}
//
//#endif
