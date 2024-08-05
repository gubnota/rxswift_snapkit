//
//  LightBulbViewModel 2.swift
//  testproj
//
//  Created by Vladislav Muravyev on 05.08.2024.
//


import Foundation
import RxSwift
import RxCocoa

class LightBulbViewModel {
    let lightBulbState = BehaviorRelay<LightBulbState>(value: .off)
    let intervalValue = BehaviorRelay<Float>(value: 0)
    let isIntervalActive = BehaviorRelay<Bool>(value: false)
    let secondsRemaining = BehaviorRelay<Int>(value: 0)

    private let disposeBag = DisposeBag()
    private var intervalTimer: Disposable?

    init() {
        setupBindings()
    }

    func toggleLightBulb() {
        lightBulbState.accept(lightBulbState.value == .on ? .off : .on)
    }

    func toggleInterval() {
        isIntervalActive.accept(!isIntervalActive.value)
        if isIntervalActive.value {
            startIntervalTimer()
        } else {
            intervalTimer?.dispose()
        }
    }

    private func startIntervalTimer() {
        intervalTimer?.dispose()
        secondsRemaining.accept(Int(intervalValue.value))
        intervalTimer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(secondsRemaining) { ($0, $1) }
            .takeWhile { $1 > 0 }
            .subscribe(onNext: { [weak self] _, remaining in
                self?.secondsRemaining.accept(remaining - 1)
                if remaining - 1 == 0 {
                    self?.toggleLightBulb()
                    self?.secondsRemaining.accept(Int(self?.intervalValue.value ?? 0))
                }
            })

        intervalTimer?.disposed(by: disposeBag)
    }

    private func setupBindings() {
        isIntervalActive
            .skip(1) // Skip the initial value
            .subscribe(onNext: { [weak self] isActive in
                if isActive {
                    self?.startIntervalTimer()
                } else {
                    self?.intervalTimer?.dispose()
                }
            })
            .disposed(by: disposeBag)
    }
}
