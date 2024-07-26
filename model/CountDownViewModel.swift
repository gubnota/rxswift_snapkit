import Foundation
import RxSwift
import RxCocoa

class CountdownViewModel {
    // Outputs
    let countdownText: Driver<String>
    let isCountingDown: Driver<Bool>
    
    // Inputs
    private let countdownValueRelay = BehaviorRelay<Int>(value: 0)
    private let isCountingDownRelay = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    init() {
        self.countdownText = countdownValueRelay
            .map { seconds in
                let minutes = String(format: "%02d", seconds / 60)
                let seconds = String(format: "%02d", seconds % 60)
                return "\(minutes):\(seconds)"
            }
            .asDriver(onErrorJustReturn: "00:00")
        
        self.isCountingDown = isCountingDownRelay
            .asDriver(onErrorJustReturn: false)
    }
    
    func startCountdown(from seconds: Int) {
        countdownValueRelay.accept(seconds)
        isCountingDownRelay.accept(true)
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(countdownValueRelay) { _, value in value - 1 }
            .takeWhile { $0 >= 0 }
            .bind(to: countdownValueRelay)
            .disposed(by: disposeBag)
        
        countdownValueRelay
            .skip(1)
            .filter { $0 == 0 }
            .map { _ in false }
            .bind(to: isCountingDownRelay)
            .disposed(by: disposeBag)
    }
    
    func resetCountdown() {
        countdownValueRelay.accept(0)
        isCountingDownRelay.accept(false)
    }
}
