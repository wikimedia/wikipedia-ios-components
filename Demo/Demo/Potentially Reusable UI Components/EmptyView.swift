import Foundation
import UIKit
import UIComponents

class EmptyView: UIView, Themeable {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(label)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: label.topAnchor),
            bottomAnchor.constraint(equalTo: label.bottomAnchor),
            leadingAnchor.constraint(equalTo: label.leadingAnchor),
            trailingAnchor.constraint(equalTo: label.trailingAnchor)
        ])
        label.text = "No items"
        updateFonts()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFonts()
    }
    
    private func updateFonts() {
        label.font = UIFont.wmf_font(.georgiaTitle3, compatibleWithTraitCollection: traitCollection)
    }
    
    func apply(theme: Theme) {
        backgroundColor = theme.colors.baseBackground
        label.textColor = theme.colors.text
    }
}
