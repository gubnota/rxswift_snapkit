
#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let postView = PostView()

            // demo data from a DemoStore singleton or other source
            let store = DemoStore.shared
            let postTitle = store.postTitle
            let postSubtitle = store.postDetails
            
            postView.postTitleLabel.text = postTitle
            postView.textView.text = postSubtitle
            
            return postView
        }
        .previewLayout(.sizeThatFits)
        .frame(width: 300, height: 150) // Adjust frame as needed
        .padding()
    }
}
#endif
