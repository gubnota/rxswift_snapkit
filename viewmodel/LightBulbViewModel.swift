import RxSwift
import RxCocoa

class LightBulbViewModel {
    let isLightOn = BehaviorRelay<Bool>(value: false)
    let interval = BehaviorRelay<Double>(value: 0)
    let isIntervalActive = BehaviorRelay<Bool>(value: false)

    private let disposeBag = DisposeBag()

    init() {
        isIntervalActive
            .distinctUntilChanged()
            .flatMapLatest { [weak self] isActive -> Observable<Int> in
                guard let self = self else { return .empty() }
                return isActive ? Observable<Int>.interval(.seconds(Int(self.interval.value)), scheduler: MainScheduler.instance) : .empty()
            }
            .subscribe(onNext: { [weak self] _ in
                self?.toggleLight()
            })
            .disposed(by: disposeBag)
    }

    func toggleLight() {
        isLightOn.accept(!isLightOn.value)
    }
}
