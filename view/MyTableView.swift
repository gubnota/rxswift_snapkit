import UIKit
import SnapKit

class MyTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let customLabels: [MyUILabel]
    private let onLabelSelected: ((String, Int) -> Void)?
    
    init(customLabels: [MyUILabel], onLabelSelected: ((String, Int) -> Void)? = nil) {
        self.customLabels = customLabels
        self.onLabelSelected = onLabelSelected
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyScrollViewCell.self, forCellReuseIdentifier: MyScrollViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100  // Initial estimated height, can be fine-tuned
    }
    
    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyScrollViewCell.reuseIdentifier, for: indexPath) as? MyScrollViewCell else {
            return UITableViewCell()
        }
        let customLabel = customLabels[indexPath.row]
        cell.configure(with: customLabel)
        return cell
    }
    
    // UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedText = customLabels[indexPath.row].text ?? "No text"
        onLabelSelected?(selectedText, indexPath.row)
    }
}

class MyScrollViewCell: UITableViewCell {
    static let reuseIdentifier = "MyScrollViewCell"
    
    private var customLabel: MyUILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with customLabel: MyUILabel) {
        // Remove any previous label from the content view
        self.customLabel?.removeFromSuperview()
        
        // Set the custom label and add it to the content view
        self.customLabel = customLabel
        contentView.addSubview(customLabel)
        
        // Apply the same constraints as before
        customLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    // Calculate the estimated height based on the label's content
    func estimatedHeight() -> CGFloat {
        guard let customLabel = customLabel else { return 16 } // Default height if label is nil
        let width = UIScreen.main.bounds.width - 16  // Considering insets
        let size = customLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 16  // Adding insets
    }
}


