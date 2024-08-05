//
//  LightBulbViewController.swift
//  testproj
//
//  Created by Vladislav Muravyev on 05.08.2024.
//
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LightBulbViewController: UIViewController {
    private let viewModel = LightBulbViewModel()
    private let disposeBag = DisposeBag()

    private let lightBulbButton = UIButton()
    private let statusLabel = UILabel()
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

        lightBulbButton.setImage(UIImage(named: "lightbulb_off"), for: .normal)
        lightBulbButton.setImage(UIImage(named: "lightbulb_on"), for: .selected)
        view.addSubview(lightBulbButton)
        lightBulbButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        statusLabel.textAlignment = .center
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(lightBulbButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        intervalSlider.minimumValue = 0
        intervalSlider.maximumValue = 10
        view.addSubview(intervalSlider)
        intervalSlider.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        triggerButton.setTitle("Trigger", for: .normal)
        triggerButton.setTitleColor(.blue, for: .normal)
        view.addSubview(triggerButton)
        triggerButton.snp.makeConstraints { make in
            make.top.equalTo(intervalSlider.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        goNextButton.setTitle("Go Next", for: .normal)
        goNextButton.setTitleColor(.blue, for: .normal)
        view.addSubview(goNextButton)
        goNextButton.snp.makeConstraints { make in
            make.top.equalTo(triggerButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func bindViewModel() {
        lightBulbButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.toggleLight()
            }
            .disposed(by: disposeBag)

        viewModel.isLightOn
            .bind(to: lightBulbButton.rx.isSelected)
            .disposed(by: disposeBag)

        viewModel.isLightOn
            .map { $0 ? "The light bulb is on" : "The light bulb is off" }
            .bind(to: statusLabel.rx.text)
            .disposed(by: disposeBag)

        intervalSlider.rx.value
            .map { Double($0) }
            .bind(to: viewModel.interval)
            .disposed(by: disposeBag)

        triggerButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.isIntervalActive.accept(!(self?.viewModel.isIntervalActive.value ?? false))
            }
            .disposed(by: disposeBag)

        goNextButton.rx.tap
            .bind { [weak self] in
                let secondVC = SecondViewController(viewModel: self?.viewModel)
                self?.navigationController?.pushViewController(secondVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
