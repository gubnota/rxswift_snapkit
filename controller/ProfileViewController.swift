import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    private let centeredView = CenteredView()
    private let usernameLabel = UILabel()
    private let passwordLabel = UILabel()
    private lazy var logoutButton = ButtonView(label: "Logout") { [weak self] in
        self?.logoutTapped()
    }
    
    private lazy var showScrollViewButton = ButtonView(label: "Scroll View") { [weak self] in
        self?.showScrollViewTapped()
    }
    private var username: String
    private var password: String
    private var timer: Timer?
    var viewModel: AppViewModel? // Injected ViewModel
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startUsernameUpdateTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopUsernameUpdateTimer()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        usernameLabel.text = "Username: \(username)"
        passwordLabel.text = "Password: \(password)"
//        
//        
//        let logoutButton = ButtonView(label: "Logout") { [weak self] in
//            self?.logoutTapped()
//        }
        let verticalView = VerticalView(views: [usernameLabel, passwordLabel, showScrollViewButton, logoutButton],
                                                 gap: 20, leadingOffset: 16, trailingOffset: 16,
                                                 verticalAlignment: .top, verticalOffset: 20)

                view.addSubview(verticalView)
                
                verticalView.snp.makeConstraints { make in
                    make.edges.equalTo(view.safeAreaLayoutGuide)
                }
//
//        centeredView.addSubview(usernameLabel)
//        centeredView.addSubview(passwordLabel)
//        centeredView.addSubview(showScrollViewButton)
//        centeredView.addSubview(logoutButton)
//
//        view.addSubview(centeredView)
//        
//        centeredView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//        
//        usernameLabel.snp.makeConstraints { make in
//            make.top.equalTo(centeredView.snp.top).offset(20)
//            make.leading.trailing.equalTo(centeredView).inset(16)
//        }
//        
//        passwordLabel.snp.makeConstraints { make in
//            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
//            make.leading.trailing.equalTo(centeredView).inset(16)
//        }
//        
//        showScrollViewButton.snp.makeConstraints { make in
//            make.top.equalTo(passwordLabel.snp.bottom).offset(30)
//            make.centerX.equalTo(centeredView)
//        }
//        
//        logoutButton.snp.makeConstraints { make in
//            make.top.equalTo(showScrollViewButton.snp.bottom).offset(30)
//            make.centerX.equalTo(centeredView)
//        }
    }

    private func startUsernameUpdateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUsernameRandomly), userInfo: nil, repeats: true)
    }

    private func stopUsernameUpdateTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func updateUsernameRandomly() {
        let randomUsername = String((0..<5).map { _ in "abcdefghijklmnopqrstuvwxyz".randomElement()! })
        updateUsername(randomUsername)
    }

    func updateUsername(_ newUsername: String) {
        usernameLabel.text = "Username: \(newUsername)"
        // Update the ViewModel with the new username
        viewModel?.lastUsername.accept(newUsername)
    }

    @objc private func logoutTapped() {
//        dismiss(animated: true, completion: nil)
//        viewModel?.lastUsername.accept(username)
//        viewModel?.lastPassword.accept(password)
        print("logout tapped")
        navigationController?.popViewController(animated: true)
    }
    @objc private func showScrollViewTapped() {
        let scrollVC = ScrollViewController() // Assuming ScrollViewController exists
        navigationController?.pushViewController(scrollVC, animated: true)
        print("showScrollViewTapped")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ProfileViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ProfileViewController(username: "admin", password: "admin").toPreview()
    }
}
#endif
