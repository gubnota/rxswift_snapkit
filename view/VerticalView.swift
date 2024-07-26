import UIKit
import SnapKit

class VerticalView: BaseView {
    private let views: [UIView]
    private let gap: CGFloat
    private let leadingOffset: CGFloat
    private let trailingOffset: CGFloat
    private let verticalAlignment: VerticalAlignment
    private let verticalOffset: CGFloat
    private let onTapHandler: ((Int, String) -> Void)?

    enum VerticalAlignment {
        case top
        case bottom
    }

    init(views: [UIView], gap: CGFloat = 10, leadingOffset: CGFloat = 20, trailingOffset: CGFloat = 20, verticalAlignment: VerticalAlignment = .top, verticalOffset: CGFloat = 20, onTapHandler: ((Int, String) -> Void)? = nil) {
        self.views = views
        self.gap = gap
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
        self.verticalAlignment = verticalAlignment
        self.verticalOffset = verticalOffset
        self.onTapHandler = onTapHandler
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        for (index, view) in views.enumerated() {
            addSubview(view)
            view.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
            view.addGestureRecognizer(tapGesture)
            view.tag = index  // Tag the view with its index

            view.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(leadingOffset)
                make.trailing.equalToSuperview().offset(-trailingOffset)
                
                if index == 0 {
                    switch verticalAlignment {
                    case .top:
                        make.top.equalToSuperview().offset(verticalOffset)
                    case .bottom:
                        break
                    }
                } else {
                    make.top.equalTo(views[index - 1].snp.bottom).offset(gap)
                }

                if index == views.count - 1 {
                    switch verticalAlignment {
                    case .top:
                        break
                    case .bottom:
                        make.bottom.equalToSuperview().offset(-verticalOffset)
                    }
                }
            }
        }
    }

    @objc private func viewTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view, let handler = onTapHandler {
            let text = (view as? UILabel)?.text ?? view.backgroundColor?.toHexString() ?? "No text"
            handler(view.tag, text)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let views = AppHelper.shared.generateViews(
                withTexts: ["Label 1", "Label 2", "Label 3"],
                colors: [UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"), UIColor(hex: "#d33086")]
            )
            let sv = VerticalView(
                views: views,
                gap: 15,
                leadingOffset: 10,
                trailingOffset: 10,
                verticalAlignment: .bottom,
                verticalOffset: 20
            ) { index, info in
                AppHelper.shared.showAlert(title: "Tapped at \(index)", message: "Info: \(info)")
            }
            sv.backgroundColor = UIColor(hex: "f1f9f0")
            sv.setRoundedCorners(radius: 28.0)
            return sv
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
