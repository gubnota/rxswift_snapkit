import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    var viewModel: AppViewModel? // Injected ViewModel
    private let disposeBag = DisposeBag()

    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = BaseButton(type: .system)

    lazy var centeredView: UIView = {
        let view = CenteredView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Re-bind or refresh UI with viewModel data
        refreshUI()
    }

    private func refreshUI() {
        guard let viewModel = viewModel else { return }

        // Update UI elements with the latest data
        usernameTextField.text = viewModel.lastUsername.value
        passwordTextField.text = viewModel.lastPassword.value

        // Enable or disable the login button based on the validity of the input fields
        let usernameValid = (usernameTextField.text ?? "").count >= 5
        let passwordValid = (passwordTextField.text ?? "").count >= 5
        let isValid = usernameValid && passwordValid

        loginButton.isEnabled = isValid
        loginButton.backgroundColor = isValid ? UIColor(hex: "#443399") : UIColor(hex: "#999999")
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        // Set placeholders and styling for the text fields
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        
        // Configure the login button
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(hex: "#999999")
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 6
        loginButton.clipsToBounds = true
        loginButton.isEnabled = false  // Initially disable the button

        // Add centered view to the main view
        view.addSubview(centeredView)
        
        // Add UI elements to the centered view
        centeredView.addSubview(usernameTextField)
        centeredView.addSubview(passwordTextField)
        centeredView.addSubview(loginButton)
        
        // Layout username text field
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(centeredView.snp.top).offset(20)
            make.leading.trailing.equalTo(centeredView).inset(16)
        }

        // Layout password text field
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(centeredView).inset(16)
        }

        // Layout login button
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(centeredView).inset(16)
            make.bottom.lessThanOrEqualTo(centeredView.snp.bottom).offset(-20)
        }
    }

    private func bindUI() {
        guard let viewModel = viewModel else { return }

        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1)

        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }

        everythingValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        everythingValid
            .map { $0 ? UIColor(hex: "#443399") : UIColor(hex: "#999999") }
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let username = self.usernameTextField.text ?? ""
                let password = self.passwordTextField.text ?? ""
                viewModel.lastUsername.accept(username)
                viewModel.lastPassword.accept(password)
                self.showProfileViewController(withUsername: username, andPassword: password)
            })
            .disposed(by: disposeBag)
    }

    private func showProfileViewController(withUsername username: String, andPassword password: String) {
        let profileVC = ProfileViewController(username: username, password: password)
        profileVC.viewModel = viewModel // Pass the ViewModel to the ProfileViewController
        //        self.present(profileVC, animated: true, completion: nil)
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}
#endif
