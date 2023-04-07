import Foundation
import UIKit

class WKEditToolbarButton: WKComponentView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
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
    }
    
    func setImage(_ image: UIImage?, for state: UIControl.State) {
        button.setImage(image, for: state)
    }
    
    public func addTarget(_ target: Any?, action: Selector, for controlEvent: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvent)
    }

    public func removeTarget(_ target: Any?, action: Selector?, for controlEvent: UIControl.Event) {
        button.removeTarget(target, action: action, for: controlEvent)
    }

    override open var intrinsicContentSize: CGSize {
        // Increase touch targets & make widths more consistent
        let superSize = super.intrinsicContentSize
        return CGSize(width: max(superSize.width, 36), height: max(superSize.height, 36))
    }
}
