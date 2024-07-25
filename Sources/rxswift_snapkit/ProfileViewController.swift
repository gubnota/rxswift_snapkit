import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    private let usernameLabel = UILabel()
    private let passwordLabel = UILabel()
    private let logoutButton = UIButton(type: .system)
    private var username: String
    private var password: String
    private var timer: Timer?
    
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
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        view.addSubview(usernameLabel)
        view.addSubview(passwordLabel)
        view.addSubview(logoutButton)
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalTo(view).inset(16)
        }

        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view).inset(16)
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
    }
    
    private func startUsernameUpdateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(updateUsernameRandomly), userInfo: nil, repeats: true)
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
    }

    @objc private func logoutTapped() {
        LoginViewController.lastUsername = username
        LoginViewController.lastPassword = password
        dismiss(animated: true, completion: nil)
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
