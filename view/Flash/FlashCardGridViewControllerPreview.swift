//
//  FlashCardGridViewControllerPreview.swift
//  my_test_proj
//
//  Created by Vladislav Muravyev on 31.07.2024.
//


#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct FlashCardGridViewControllerPreview: PreviewProvider {
    static var previews: some View {
        FlashCardGridViewController().toPreview()
    }
}
#endif
