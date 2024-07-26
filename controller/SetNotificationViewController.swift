import UIKit
import UserNotifications

class SetNotificationViewController: UIViewController {
    private let countdownView = CountdownView()
    private let countdownViewModel = CountdownViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        view.addSubview(countdownView)
        countdownView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        countdownView.viewModel = countdownViewModel

        let setButton = UIButton(type: .system)
        setButton.setTitle("Set Reminder", for: .normal)
        view.addSubview(setButton)
        setButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(countdownView.snp.bottom).offset(20)
        }

        setButton.addTarget(self, action: #selector(setReminder), for: .touchUpInside)
    }

    @objc private func setReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Time to review your words!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Example: 5 seconds

        let request = UNNotificationRequest(identifier: "WordReviewReminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            }
        }
    }
}
