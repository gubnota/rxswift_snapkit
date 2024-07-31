//
//  IntroViewController.swift
//
//  Created by Vladislav Muravyev on 31.07.2024.
//
import UIKit
import SnapKit

class IntroViewController: UIViewController {
    private var grid: BaseView!// MyScrollableStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func callback(id: Int) {
        var vc: UIViewController?

        switch id {
        case 1:
            vc = ScrollViewController()
            
        case 2:
            let loginVC = LoginViewController()
            loginVC.viewModel = AppViewModel() // Ensure LoginViewController has a viewModel property
            vc = loginVC
            
        default:
            vc = FlashCardGridViewController()
        }
        
        if let viewController = vc {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        grid.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)//.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    func setupUI(){
        // Hide the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
//        grid = MyScrollableStackView(views: AppHelper.shared.generateViews(withTexts: ["Flash cards","Scroll View","Login View"])){text,id in
//            self.callback(id: id)
//        }
        grid = MyGridView(views: AppHelper.shared.generateViews(withTexts: ["Flash cards","Scroll View","Login View"]),tapHandler: { id in
            self.callback(id: id)
        })
//        view.snp.makeConstraints{make in
//            make.edges.equalToSuperview()
//        }
        view.addSubview(grid)
        grid.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)//equalToSuperview()
        }
    }
    
}

