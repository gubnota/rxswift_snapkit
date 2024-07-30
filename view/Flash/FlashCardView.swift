import UIKit
import RxSwift
import RxCocoa
import SnapKit

class FlashCardView: UIView {
    enum CardState {
        case face, back
    }
    
    // Observables
    let state: BehaviorSubject<CardState>
    private let disposeBag = DisposeBag()
    
    // Subviews
    private let faceView = UIView()
    private let backView = UIView()
    private let frontLabel = UILabel()
    private let backImageView = UIImageView()
    
    init(frame: CGRect, text: String, state: CardState = .back) {
        self.state = BehaviorSubject<CardState>(value: state)
        super.init(frame: frame)
        setupViews()
        frontLabel.text = text
        setupBindings()
        setupGesture()
        setInitialState(state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // General properties
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        // Face view
        let faceLayer = CAGradientLayer()
        faceLayer.colors = [UIColor(hex: "ffdd00").cgColor, UIColor(hex: "ffdd99").cgColor]
        faceLayer.startPoint = CGPoint(x: 0, y: 0)
        faceLayer.endPoint = CGPoint(x: 1, y: 1)
        faceLayer.frame = bounds
        faceLayer.cornerRadius = 20
        faceView.layer.insertSublayer(faceLayer, at: 0)
        faceView.layer.cornerRadius = 20
        faceView.layer.masksToBounds = true
        
        frontLabel.textColor = .black
        frontLabel.textAlignment = .center
        frontLabel.numberOfLines = 0
        faceView.addSubview(frontLabel)
        
        frontLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        
        // Back view
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "0DD2D2").cgColor, UIColor(hex: "05B5CD").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 20
        backView.layer.insertSublayer(gradientLayer, at: 0)
        backView.layer.cornerRadius = 20
        backView.layer.masksToBounds = true
        
        // Set up the image view for the back view
        if let img = UIImage(named: "wing") {
            backImageView.image = img
        }
        backImageView.contentMode = .scaleAspectFit
        backView.addSubview(backImageView)
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(36)
        }
        
        // Add views
        addSubview(backView)
        addSubview(faceView)
        
        // Setup initial state
        faceView.isHidden = true
    }
    
    private func setupBindings() {
        state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.animateFlip(to: state)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flip))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func flip() {
        let newState: CardState = try! state.value() == .face ? .back : .face
        state.onNext(newState)
    }
    
    private func animateFlip(to state: CardState) {
        let showFace = state == .face
        let fromView = showFace ? backView : faceView
        let toView = showFace ? faceView : backView
        let options: UIView.AnimationOptions = showFace ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        UIView.transition(from: fromView, to: toView, duration: 0.6, options: [options, .showHideTransitionViews]) { _ in
            fromView.isHidden = true
            toView.isHidden = false
        }
    }
    
    private func setInitialState(_ initialState: CardState) {
        faceView.isHidden = initialState != .face
        backView.isHidden = initialState == .face
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        faceView.frame = bounds
        backView.frame = bounds
        
        if let faceGradientLayer = faceView.layer.sublayers?.first as? CAGradientLayer {
            faceGradientLayer.frame = faceView.bounds
        }
        
        if let backGradientLayer = backView.layer.sublayers?.first as? CAGradientLayer {
            backGradientLayer.frame = backView.bounds
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = FlashCardView(frame: .zero, text: "Sample Text", state: .back)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {view.flip()}
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {view.flip()}
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {view.flip()}
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {view.flip()}
            return view
        }
        .frame(width: 150, height: 150) // Adjust frame as needed
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
