import UIKit
import SnapKit

class ScrollViewController: UIViewController {
    private var tableView: MyTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        // Create labels with rounded corners using a closure
        let labelTexts = ["Label 1", "Label 2", "Label 3","Label 1", "Label 2", "Label 3","Label 1", "Label 2", "Label 3","Label 1"]
        let labelColors: [UIColor] = [UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363")]
        let labels: [MyUILabel] = labelTexts.enumerated().map { index, text in
            let label = MyUILabel(customHeight: 64.0)
            label.text = text
            label.backgroundColor = labelColors[index]
            label.textAlignment = .center
            label.layer.cornerRadius = 8.0
            label.layer.masksToBounds = true
            return label
        }


        tableView = MyTableView(customLabels: labels) { [weak self] selectedText, index in
            let alert = UIAlertController(title: "Label Selected", message: "Text: \(selectedText)\nID: \(index)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true, completion: nil)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ScrollViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ScrollViewController().toPreview()
    }
}
#endif
