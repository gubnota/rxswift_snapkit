import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LightBulbViewController: UIViewController {
    private let viewModel = LightBulbViewModel()
    private let disposeBag = DisposeBag()

    private let lightBulbButton = UIButton()
    private let stateLabel = UILabel()
    private let intervalLabel = UILabel()
    private let intervalSlider = UISlider()
    private let triggerButton = UIButton()
    private let goNextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(lightBulbButton)
        view.addSubview(stateLabel)
        view.addSubview(intervalSlider)
        view.addSubview(triggerButton)
        view.addSubview(goNextButton)
        view.addSubview(intervalLabel)

        lightBulbButton.setImage(UIImage(named: "lightbulb_off"), for: .normal)
        lightBulbButton.setImage(UIImage(named: "lightbulb_on"), for: .selected)
        lightBulbButton.snp.makeConstraints { make in
//            make.center.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets.top).offset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }

        stateLabel.textAlignment = .center
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(lightBulbButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        intervalLabel.font = UIFont.systemFont(ofSize: 30)
        
        intervalLabel.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        intervalSlider.minimumValue = 0
        intervalSlider.maximumValue = 10
        intervalSlider.snp.makeConstraints { make in
            make.top.equalTo(intervalLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        triggerButton.setTitle("Start Interval", for: .normal)
        triggerButton.setTitleColor(.white, for: .normal)
        triggerButton.backgroundColor = .orange
        triggerButton.layer.cornerRadius = 10
        triggerButton.snp.makeConstraints { make in
            make.top.equalTo(intervalSlider.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }

        goNextButton.setTitle("Go Next", for: .normal)
        goNextButton.setTitleColor(.white, for: .normal)
        goNextButton.backgroundColor = .blue
        goNextButton.layer.cornerRadius = 10
        goNextButton.snp.makeConstraints { make in
            make.top.equalTo(triggerButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }

    private func bindViewModel() {
        lightBulbButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.toggleLightBulb()
            }
            .disposed(by: disposeBag)

//        viewModel.lightBulbState
//            .map { $0 == .on ? UIImage(systemName: "lightbulb.fill") : UIImage(systemName: "lightbulb") }
//            .bind(to: lightBulbButton.rx.image())
//            .disposed(by: disposeBag)
        viewModel.lightBulbState
            .map { $0 == .on ? true : false }
            .bind(to: lightBulbButton.rx.isSelected)
            .disposed(by: disposeBag)

        viewModel.lightBulbState
            .map { $0 == .on ? "The light bulb is on" : "The light bulb is off" }
            .bind(to: stateLabel.rx.text)
            .disposed(by: disposeBag)

        intervalSlider.rx.value
            .bind(to: viewModel.intervalValue)
            .disposed(by: disposeBag)

        triggerButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.toggleInterval()
            }
            .disposed(by: disposeBag)

        viewModel.isIntervalActive
            .map { $0 ? "Stop Interval" : "Start Interval" }
            .bind(to: triggerButton.rx.title())
            .disposed(by: disposeBag)

        goNextButton.rx.tap
            .bind { [weak self] in
                let nextVC = SecondViewController(viewModel: self?.viewModel)
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.isIntervalActive, viewModel.secondsRemaining, viewModel.intervalValue)
            .map { isActive, secondsRemaining, intervalValue -> String in
                if isActive {
                    return "\(secondsRemaining) seconds remained out of \(Int(intervalValue))"
                } else {
                    return "\(Int(intervalValue)) seconds"
                }
            }
            .bind(to: intervalLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
