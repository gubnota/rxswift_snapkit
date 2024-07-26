import UIKit
import SnapKit

class MyRowView: BaseView {
    private let views: [UIView]
    private let spacing: CGFloat
    private let padding: UIEdgeInsets
    private let tapHandler: ((Int) -> Void)?

    init(views: [UIView], spacing: CGFloat = 10, padding: UIEdgeInsets = .zero, tapHandler: ((Int) -> Void)? = nil) {
        self.views = views
        self.spacing = spacing
        self.padding = padding
        self.tapHandler = tapHandler
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        for (index, view) in views.enumerated() {
            addSubview(view)

            view.snp.makeConstraints { make in
                if index == 0 {
                    make.leading.equalToSuperview().offset(padding.left)
                } else {
                    make.leading.equalTo(views[index - 1].snp.trailing).offset(spacing)
                }

                if index == views.count - 1 {
                    make.trailing.lessThanOrEqualToSuperview().offset(-padding.right)
                }
                
                make.top.equalToSuperview().offset(padding.top)
                make.bottom.equalToSuperview().offset(-padding.bottom)
            }

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
            view.addGestureRecognizer(tapGesture)
            view.isUserInteractionEnabled = true
            view.tag = index
        }
    }

    @objc private func viewTapped(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        tapHandler?(view.tag)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct MyRowView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            // Create views for the row
 
            // Create views for the row
            let views = AppHelper.shared.generateViews(withTexts: ["Label 1", "Label 2", "Label 3"],colors: [UIColor(hex: "#630d83"), UIColor(hex: "#d33086"),
                                                                                                             UIColor(hex: "#0d8363")])

            let rowView = MyRowView(views: views, spacing: 10, padding: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)) { index in
                    AppHelper.shared.showAlert(title: "Tapped at \(index)", message: "Text: tapped at ID: \(index)")

            }
            rowView.backgroundColor = .lightGray
            return rowView
        }
        .frame(height: 80)
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
