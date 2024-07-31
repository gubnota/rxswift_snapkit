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

