import UIKit
import SnapKit

class MyGridView: BaseView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let collectionView: UICollectionView
    private let views: [UIView]
    private let columns: Int
    private let rowSpacing: CGFloat
    private let columnSpacing: CGFloat
    private let tapHandler: ((Int) -> Void)?

    init(views: [UIView], columns: Int = 2, rowSpacing: CGFloat = 10, columnSpacing: CGFloat = 10, tapHandler: ((Int) -> Void)? = nil) {
        self.views = views
        self.columns = columns
        self.rowSpacing = rowSpacing
        self.columnSpacing = columnSpacing
        self.tapHandler = tapHandler
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = columnSpacing
        layout.minimumLineSpacing = rowSpacing
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: .zero)
        
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.reuseIdentifier)
        collectionView.isScrollEnabled = true
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return views.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.reuseIdentifier, for: indexPath) as? GridCollectionViewCell else {
            return UICollectionViewCell()
        }
        let view = views[indexPath.item]
        cell.configure(with: view)
        return cell
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapHandler?(indexPath.item)
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - (CGFloat(columns - 1) * columnSpacing)
        let itemWidth = availableWidth / CGFloat(columns)

        if indexPath.item == 0 {
            // Make the first view larger
            return CGSize(width: itemWidth * 2 + columnSpacing, height: 200)
        } else {
            return CGSize(width: itemWidth, height: 100)
        }
    }
}

// Custom cell class to hold the views
class GridCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GridCollectionViewCell"
    
    private var customView: UIView?
    
    func configure(with view: UIView) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        customView = view
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct MyGridView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            // Create views for the grid
            let views = AppHelper.shared.generateViews()
            let gridView = MyGridView(views: views, columns:2) { index in
                AppHelper.shared.showAlert(title: "Tapped at \(index)", message: views[index].backgroundColor!.toHexString())
            }
            return gridView
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
