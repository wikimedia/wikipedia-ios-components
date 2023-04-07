import Foundation
import UIKit

class WKEditExpandToolbarButton: WKComponentView {

    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        button.setImage(WKIcon.chevonRightCircleFill, for: .normal)
        
        button.imageView?.contentMode = .scaleAspectFit
    }
    
    public func addTarget(_ target: Any?, action: Selector, for controlEvent: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvent)
    }

    public func removeTarget(_ target: Any?, action: Selector?, for controlEvent: UIControl.Event) {
        button.removeTarget(target, action: action, for: controlEvent)
    }
}
