import SwiftUI
import SnapKit
import RxSwift

class FlashCardGridViewController: UIViewController {
    private var flashCardGridView: FlashCardGridView!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlashCardGridView()
    }

    private func setupFlashCardGridView() {
        let flashCardData: [(text: String, state: FlashCardView.CardState)] = [
            (text: "Apple", state: .back),
            (text: "Banana", state: .back),
            (text: "Cherry", state: .back),
            (text: "Date", state: .back),
            (text: "Elderberry", state: .back),
            (text: "Fig", state: .back),
            (text: "Grape", state: .back),
            (text: "Honeydew", state: .back),
            (text: "Apple", state: .back),
            (text: "Banana", state: .back),
            (text: "Cherry", state: .back),
            (text: "Date", state: .back),
        ]
        
        flashCardGridView = FlashCardGridView(cardData: flashCardData)
        
        flashCardGridView.cardTappedSubject
            .subscribe(onNext: { [weak self] text, state in
                self?.handleCardTapped(text: text, state: state)
            })
            .disposed(by: disposeBag)
        
        view.addSubview(flashCardGridView)
        flashCardGridView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func handleCardTapped(text: String, state: FlashCardView.CardState) {
        print("Card tapped: \(text) with state \(state)")
        // Handle the card tap, such as flipping the card or updating UI
    }
}

struct FlashCardGridViewControllerPreview: PreviewProvider {
    static var previews: some View {
        FlashCardGridViewController().toPreview()
    }
}
