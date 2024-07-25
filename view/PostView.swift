//
//  PostView.swift
//  ReStructV
//
//  Created by Hafiz on 05/04/2021.
//

import UIKit
import SnapKit

class PostView: UIView {
    lazy var postTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = .darkGray
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        return textView
    }()
    
    lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postTitleLabel, textView])
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        return scrollView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        // cosmetics
            backgroundColor = .systemBackground
        
        // constraints
        scrollView.addSubview(bodyStackView)
        scrollView.contentSize = bodyStackView.frame.size
        
        bodyStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalTo(scrollView.snp.width).inset(24)
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
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
