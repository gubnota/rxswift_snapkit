import UIKit
import SnapKit

class CenteredView: BaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupView() {
        // Set background color
        backgroundColor = UIColor(hex: "#f0f0fd")
        setRoundedCorners(radius: 10)
        if (superview != nil){
            // Set up constraints only when the view is added to a superview
            self.snp.makeConstraints { make in
//                make.center.equalToSuperview()
                make.leading.equalTo(superview!).offset(20)
                make.trailing.equalTo(superview!).offset(-20)
//                make.width.equalToSuperview().multipliedBy(1)
//                make.top.equalTo(superview!).offset(100)
                make.centerY.equalTo(superview!)
                if UIDevice.current.userInterfaceIdiom == .pad {
                    make.height.equalTo(superview!.snp.height).multipliedBy(0.5)
                } else {
                    make.height.equalTo(300)
                }
            }
        }

    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupView()
}
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            return CenteredView()
        }
        .previewLayout(.sizeThatFits)
        .frame(width: 300, height: 400) // Set desired preview size
        .padding()
    }
}
#endif
