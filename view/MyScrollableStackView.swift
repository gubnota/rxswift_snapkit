import UIKit
import SnapKit

class MyScrollableStackView: BaseView {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let isHorizontal: Bool

    init(views: [UIView], isHorizontal: Bool = false, onViewTapped: ((String, Int) -> Void)?) {
        self.isHorizontal = isHorizontal
        super.init(frame: .zero)
        setupView()
        addViews(views, onViewTapped: onViewTapped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            if isHorizontal {
                make.height.equalTo(scrollView.frameLayoutGuide) // Ensure the stackView height matches the scrollView height
            } else {
                make.width.equalTo(scrollView.frameLayoutGuide) // Ensure the stackView width matches the scrollView width
            }
        }

        stackView.axis = isHorizontal ? .horizontal : .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
    }

    private func addViews(_ views: [UIView], onViewTapped: ((String, Int) -> Void)?) {
        for (index, view) in views.enumerated() {
            addArrangedSubview(view)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
            view.addGestureRecognizer(tapGesture)
            view.isUserInteractionEnabled = true
            view.tag = index
        }
        self.onViewTapped = onViewTapped
    }

    private var onViewTapped: ((String, Int) -> Void)?
    
    @objc private func viewTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view, let onViewTapped = onViewTapped {
            let text = (view as? UILabel)?.text ?? "No text"
            onViewTapped(text, view.tag)
        }
    }

    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }

    func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
}

