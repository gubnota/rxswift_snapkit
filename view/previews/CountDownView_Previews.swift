#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview{CountdownView()}
            .previewLayout(.fixed(width: 300, height: 400))
    }
}

#endif
