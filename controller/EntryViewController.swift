import UIKit

class EntryViewController: UIViewController {
    private let appViewModel = AppViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationHandler.shared.requestNotificationAuthorization()

        // Navigate to the initial view controller
//        navigateToInitialViewController()
        configureForPreview()

    }
    
    private func navigateToInitialViewController() {
//        if let _ = appViewModel.lastUsername.value, let _ = appViewModel.lastPassword.value {
//            showProfileViewController()
//        } else {
//            showLoginViewController()
//        }
    }
    
    private func showLoginViewController() {
        let loginVC = LoginViewController()
        loginVC.viewModel = appViewModel
        navigationController?.setViewControllers([loginVC], animated: false)
    }
    
    private func showProfileViewController() {
        guard let username = appViewModel.lastUsername.value, let password = appViewModel.lastPassword.value else {
            showLoginViewController()
            return
        }
        
        let profileVC = ProfileViewController(username: username, password: password)
        profileVC.viewModel = appViewModel
        navigationController?.setViewControllers([profileVC], animated: false)
    }
    // Method to configure the view controller for preview purposes
    func configureForPreview() {
        navigationController?.setViewControllers([LightBulbViewController()], animated: false)
//        showLoginViewController()
        
    }
}

