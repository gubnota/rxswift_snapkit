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

    init(viewModel: LightBulbViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel?.lightBulbState
            .map { $0 == .on ? UIColor.yellow : UIColor.blue }
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
}
