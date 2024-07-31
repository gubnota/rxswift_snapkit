import UIKit
import RxSwift
import RxCocoa

class CountdownView: BaseView {
    private let countdownLabel = UILabel()
    private let startButton = UIButton(type: .system)
    private let disposeBag = DisposeBag()
    var viewModel: CountdownViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        // Setup countdownLabel
        addSubview(countdownLabel)
        countdownLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        countdownLabel.textAlignment = .center
        countdownLabel.font = UIFont.boldSystemFont(ofSize: 48)

        // Setup startButton
        startButton.setTitle("Start", for: .normal)
        addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.top.equalTo(countdownLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        startButton.addTarget(self, action: #selector(startCountdown), for: .touchUpInside)
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.countdownText
            .drive(countdownLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isCountingDown
            .map { !$0 }
            .drive(startButton.rx.isHidden)
            .disposed(by: disposeBag)
    }

    @objc private func startCountdown() {
        viewModel?.startCountdown(from: 120) // Example: start from 2 minutes
    }
}
