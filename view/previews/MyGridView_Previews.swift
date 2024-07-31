//
//  MyGridView_Previews.swift
//
//  Created by Vladislav Muravyev on 31.07.2024.
//


#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct MyGridView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            // Create views for the grid
            let views = AppHelper.shared.generateViews()
            let gridView = MyGridView(views: views, columns:2) { index in
                AppHelper.shared.showAlert(title: "Tapped at \(index)", message: views[index].backgroundColor!.toHexString())
            }
            return gridView
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
