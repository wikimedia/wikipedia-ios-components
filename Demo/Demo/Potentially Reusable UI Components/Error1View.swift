import Foundation
import UIKit
import Components

class Error1View: UIView, Themeable {
    
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
        label.text = "There has been an error"
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFonts()
    }
    
    private func updateFonts() {
        label.font = UIFont.wmf_font(.boldTitle1, compatibleWithTraitCollection: traitCollection)
    }
    
    func apply(theme: Theme) {
        backgroundColor = theme.colors.baseBackground
        label.textColor = theme.colors.text
    }
}
