import UIKit
import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationHandler()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    // Method to request notification authorization
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Request authorization failed: \(error)")
            } else if granted {
                print("Authorization granted")
            } else {
                print("Authorization denied")
            }
        }
    }
    
    // MARK: - UNUserNotificationCenterDelegate Methods
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
