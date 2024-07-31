//
//  CenteredView_Previews.swift
//
//  Created by Vladislav Muravyev on 31.07.2024.
//


#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct CenteredView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview{CenteredView()}
            .previewLayout(.fixed(width: 300, height: 400))
    }
}

//struct CenteredView_Previews: PreviewProvider {
//        static var previews: some View {
//            UIViewPreview {
//                return CenteredView()
//            }
//            .previewLayout(.sizeThatFits)
//            .frame(width: 300, height: 400) // Set desired preview size
//            .padding()
//        }
//    }
#endif
