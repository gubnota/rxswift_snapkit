import SwiftUI
import SnapKit
import RxSwift
import RxCocoa

class FlashCardGridView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let collectionView: UICollectionView
    private let cardData: [(text: String, state: FlashCardView.CardState)]
    private let disposeBag = DisposeBag()
    
    // Observable to emit tapped card data
    let cardTappedSubject = PublishSubject<(String, FlashCardView.CardState)>()
    
    // Define the dimensions for each flashcard
    private let flashCardSize = CGSize(width: 150, height: 150)
    
    init(cardData: [(text: String, state: FlashCardView.CardState)]) {
        self.cardData = cardData
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = flashCardSize
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FlashCardCell.self, forCellWithReuseIdentifier: FlashCardCell.identifier)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashCardCell.identifier, for: indexPath) as! FlashCardCell
        let data = cardData[indexPath.item]
        cell.configure(with: data.text, state: data.state)
        cell.onCardTapped = { [weak self] in
            self?.cardTappedSubject.onNext((data.text, data.state))
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let totalCellWidth = flashCardSize.width * CGFloat(collectionView.numberOfItems(inSection: section))
        let totalSpacingWidth = layout.minimumInteritemSpacing * CGFloat(collectionView.numberOfItems(inSection: section) - 1)
        let totalWidth = totalCellWidth + totalSpacingWidth
        
        let leftInset = (collectionView.bounds.width - totalWidth) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 16, left: max(leftInset, 16), bottom: 16, right: max(rightInset, 16))
    }
}

class FlashCardCell: UICollectionViewCell {
    static let identifier = "FlashCardCell"
    var flashCardView: FlashCardView!
    var onCardTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        flashCardView = FlashCardView(frame: .zero, text: "", state: .back)
        contentView.addSubview(flashCardView)
        flashCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        flashCardView.addGestureRecognizer(tapGesture)
    }
    
    func configure(with text: String, state: FlashCardView.CardState) {
        flashCardView.removeFromSuperview()
        flashCardView = FlashCardView(frame: .zero, text: text, state: state)
        contentView.addSubview(flashCardView)
        flashCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func cardTapped() {
        onCardTapped?()
    }
}
