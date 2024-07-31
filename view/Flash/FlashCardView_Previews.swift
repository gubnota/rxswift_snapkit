//
//  FlashCardView_Previews.swift
//
//  Created by Vladislav Muravyev on 31.07.2024.
//


#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = FlashCardView(frame: .zero, text: "Sample Text", state: .back)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {view.flip()}
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {view.flip()}
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {view.flip()}
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {view.flip()}
            return view
        }
        .frame(width: 150, height: 150) // Adjust frame as needed
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
