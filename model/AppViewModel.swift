import UIKit
import RxSwift
import RxCocoa

class AppViewModel {
    // Shared state
    let lastUsername = BehaviorRelay<String?>(value: nil)
    let lastPassword = BehaviorRelay<String?>(value: nil)
    
    private let disposeBag = DisposeBag()
    
    init() {
        // Load saved credentials on initialization
        lastUsername.accept(UserDefaults.standard.string(forKey: "lastUsername"))
        lastPassword.accept(UserDefaults.standard.string(forKey: "lastPassword"))
        
        // Observe changes and save to UserDefaults
        lastUsername
            .skip(1) // Skip initial value to avoid saving default nil
            .subscribe(onNext: { username in
                UserDefaults.standard.set(username, forKey: "lastUsername")
            })
            .disposed(by: disposeBag)
        
        lastPassword
            .skip(1)
            .subscribe(onNext: { password in
                UserDefaults.standard.set(password, forKey: "lastPassword")
            })
            .disposed(by: disposeBag)
    }
}
