import UIKit
import SnapKit
import RxSwift
import RxCocoa
import UserNotifications

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
    
    private lazy var setNotificationButton = ButtonView(label: "Set Notification") { [weak self] in
        self?.setNotificationTapped()
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
        
        let verticalView = VerticalView(views: [usernameLabel, passwordLabel, showScrollViewButton, setNotificationButton, logoutButton],
                                        gap: 20, leadingOffset: 16, trailingOffset: 16,
                                        verticalAlignment: .top, verticalOffset: 20)

        view.addSubview(verticalView)
        
        verticalView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
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
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func showScrollViewTapped() {
        let scrollVC = ScrollViewController()
        navigationController?.pushViewController(scrollVC, animated: true)
    }

    @objc private func setNotificationTapped() {
//        let notificationVC = SetNotificationViewController()
//        navigationController?.pushViewController(notificationVC, animated: true)

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "This is your reminder notification!"
            content.sound = .default
        
        // Trigger the notification after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Create the request
        let request = UNNotificationRequest(identifier: "FiveSecondNotification", content: content, trigger: trigger)
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling failed: \(error)")
            } else {
                print("Notification scheduled")
            }
        }
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
