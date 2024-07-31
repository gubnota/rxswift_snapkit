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

