//import UIKit
//import SnapKit
//
//class MyScrollViewCell: UITableViewCell {
//    static let reuseIdentifier = "MyScrollViewCell"
//    
//    private var customLabel: MyUILabel?
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(with customLabel: MyUILabel) {
//        // Remove any previous label from the content view
//        self.customLabel?.removeFromSuperview()
//        
//        // Set the custom label and add it to the content view
//        self.customLabel = customLabel
//        contentView.addSubview(customLabel)
//        
//        // Apply the same constraints as before
//        customLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(8)
//        }
//    }
//    
//    // Calculate the estimated height based on the label's content
//    func estimatedHeight() -> CGFloat {
//        guard let customLabel = customLabel else { return 16 } // Default height if label is nil
//        let width = UIScreen.main.bounds.width - 16  // Considering insets
//        let size = customLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
//        return size.height + 16  // Adding insets
//    }
//}
//
//class MyTableView: UIView, UITableViewDataSource, UITableViewDelegate {
//    private let tableView = UITableView()
//    private let customLabels: [MyUILabel]
//    private let onLabelSelected: ((String, Int) -> Void)?
//    
//    init(customLabels: [MyUILabel], onLabelSelected: ((String, Int) -> Void)? = nil) {
//        self.customLabels = customLabels
//        self.onLabelSelected = onLabelSelected
//        super.init(frame: .zero)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupView() {
//        addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(MyScrollViewCell.self, forCellReuseIdentifier: MyScrollViewCell.reuseIdentifier)
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 100  // Initial estimated height, can be fine-tuned
//    }
//    
//    // UITableViewDataSource Methods
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return customLabels.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyScrollViewCell.reuseIdentifier, for: indexPath) as? MyScrollViewCell else {
//            return UITableViewCell()
//        }
//        let customLabel = customLabels[indexPath.row]
//        cell.configure(with: customLabel)
//        return cell
//    }
//    
//    // UITableViewDelegate Methods
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedText = customLabels[indexPath.row].text ?? "No text"
//        onLabelSelected?(selectedText, indexPath.row)
//    }
//}
//
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//@available(iOS 13.0, *)
//struct MyScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewPreview ({
//            // Create labels with rounded corners using a closure
//            let labelTexts = ["Label 1", "Label 2", "Label 3","Label 1", "Label 2", "Label 3","Label 1", "Label 2", "Label 3","Label 1"]
//            let labelColors: [UIColor] = [UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086"),UIColor(hex: "#0d8363")]
//            let labels: [MyUILabel] = labelTexts.enumerated().map { index, text in
//                let label = MyUILabel(customHeight: index%2==0 ? 100.0 : 64.0)
//                label.text = text
//                label.backgroundColor = labelColors[index]
//                label.textAlignment = .center
//                label.layer.cornerRadius = 8.0
//                label.layer.masksToBounds = true
//                return label
//            }
//
//            let sv = MyTableView(customLabels: labels) { selectedText, index in
//                // Display an alert with the selected text and index
//                let alert = UIAlertController(title: "Label Selected", message: "Text: \(selectedText)\nID: \(index)", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default))
//                
//                // Assuming we have a root view controller to present the alert
//                if let rootVC = UIApplication.shared.windows.first?.rootViewController {
//                    rootVC.present(alert, animated: true, completion: nil)
//                }
//            }
//            sv.backgroundColor = UIColor(hex: "f1f9f0")
//            sv.layer.cornerRadius = 28.0
//            sv.layer.masksToBounds = true
//            return sv
//        }())
//        .previewLayout(.sizeThatFits)
//        .padding()
//    }
//}
//#endif
