import UIKit
import SnapKit

class ButtonView: UIView {
    let buttonHeight: CGFloat = 54
    static let height: CGFloat = 86
    
    private var callback: (() -> Void)?
    
    lazy var demoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = button.tintColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonHeight / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    init(label: String, callback: @escaping () -> Void) {
        super.init(frame: .zero)
        self.callback = callback
        demoButton.setTitle(label, for: .normal)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(demoButton)
        demoButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    @objc private func buttonClicked() {
        callback?()
    }
}
