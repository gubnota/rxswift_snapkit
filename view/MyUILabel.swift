import UIKit
import SnapKit

class MyUILabel: UILabel {
    private var customHeight: CGFloat

    init(frame: CGRect = .zero, customHeight: CGFloat = 64.0) {
        self.customHeight = customHeight
        super.init(frame: frame)
        setupStyle()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle() {
        self.font = UIFont.boldSystemFont(ofSize: 24) // Set font to bold with a large size
        self.textColor = .white // Set text color to white
        self.textAlignment = .center
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.numberOfLines = 0 // Allow multiple lines
    }

    private func setupConstraints() {
        // If the label is added to a superview, set its height constraint to the custom height
        self.snp.makeConstraints { make in
            make.height.equalTo(customHeight)
        }
    }
    var estimatedHeight: CGFloat {
        return customHeight
    }
}
