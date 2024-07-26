import UIKit
import SnapKit

class BaseView: UIView {
    private var heightConstraint: Constraint?

    // Custom styles for all UIViews
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Method to set rounded corners
    func setRoundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    // Method to set height using SnapKit
    func setHeight(_ height: CGFloat) {
        self.snp.updateConstraints { make in
            self.heightConstraint = make.height.equalTo(height).constraint
        }
    }
    
    // Optional: Initial setup for height if needed
    func initialSetup(height: CGFloat) {
        self.snp.makeConstraints { make in
            self.heightConstraint = make.height.equalTo(height).constraint
        }
    }
}

class BaseLabel: UILabel {
    // Custom styles for all UILabels
}

class BaseButton: UIButton {
    // Custom styles for all UIButtons
}
