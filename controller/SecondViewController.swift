//
//  SecondViewController.swift
//  testproj
//
//  Created by Vladislav Muravyev on 05.08.2024.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SecondViewController: UIViewController {
    private let viewModel: LightBulbViewModel?
    private let disposeBag = DisposeBag()

    private let stateLabel = UILabel()
    private let toggleButton = UIButton()

    init(viewModel: LightBulbViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white

        stateLabel.textAlignment = .center
        stateLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        toggleButton.setTitle("Toggle Light", for: .normal)
        toggleButton.setTitleColor(.white, for: .normal)
        toggleButton.backgroundColor = .blue
        toggleButton.layer.cornerRadius = 10
        view.addSubview(toggleButton)
        toggleButton.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }

        viewModel.lightBulbState
            .map { $0 == .on ? "The light bulb is on" : "The light bulb is off" }
            .bind(to: stateLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.lightBulbState
            .map { $0 == .on ? UIColor.yellow : UIColor.blue }
            .subscribe(onNext: { [weak self] color in
                UIView.animate(withDuration: 0.3) {
                    self?.view.backgroundColor = color
                }
            })
            .disposed(by: disposeBag)

        toggleButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.toggleLightBulb()
            }
            .disposed(by: disposeBag)
    }
}
