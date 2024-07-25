import UIKit
import SnapKit

class VerticalView: BaseView {
    private let views: [UIView]
    private let gap: CGFloat
    private let leadingOffset: CGFloat
    private let trailingOffset: CGFloat
    private let verticalAlignment: VerticalAlignment
    private let verticalOffset: CGFloat

    enum VerticalAlignment {
        case top
        case bottom
    }

    init(views: [UIView], gap: CGFloat = 10, leadingOffset: CGFloat = 20, trailingOffset: CGFloat = 20, verticalAlignment: VerticalAlignment = .top, verticalOffset: CGFloat = 20) {
        self.views = views
        self.gap = gap
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
        self.verticalAlignment = verticalAlignment
        self.verticalOffset = verticalOffset
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        for (index, view) in views.enumerated() {
            addSubview(view)
            view.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(leadingOffset)
                make.trailing.equalToSuperview().offset(-trailingOffset)
                
                if index == 0 {
                    switch verticalAlignment {
                    case .top:
                        make.top.equalToSuperview().offset(verticalOffset)
                    case .bottom:
                        // Don't set the top constraint for the first view when aligning to bottom
                        break
                    }
                } else {
                    make.top.equalTo(views[index - 1].snp.bottom).offset(gap)
                }

                if index == views.count - 1 {
                    switch verticalAlignment {
                    case .top:
                        break
                    case .bottom:
                        make.bottom.equalToSuperview().offset(-verticalOffset)
                    }
                }
            }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            // Create labels with rounded corners using a closure
            let labelTexts = ["Label 1", "Label 2", "Label 3"]
            let labelColors: [UIColor] = [UIColor(hex: "#0d8363"), UIColor(hex: "#630d83"),  UIColor(hex: "#d33086")]
            let labels: [MyUILabel] = labelTexts.enumerated().map { index, text in
                let label = MyUILabel(customHeight: 64.0)
                label.text = text
                label.backgroundColor = labelColors[index]
                label.textAlignment = .center
                label.layer.cornerRadius = 8.0
                label.layer.masksToBounds = true
                return label
            }

            let sv = VerticalView(views: labels, gap: 15, leadingOffset: 10, trailingOffset: 10, verticalAlignment: .bottom, verticalOffset: 20)
            sv.backgroundColor = UIColor(hex: "f1f9f0")
            sv.setRoundedCorners(radius: 28.0)
            return sv
        }
        .previewLayout(.sizeThatFits)
//        .frame(width: 300, height: 400)
        .padding()
    }
}
#endif
