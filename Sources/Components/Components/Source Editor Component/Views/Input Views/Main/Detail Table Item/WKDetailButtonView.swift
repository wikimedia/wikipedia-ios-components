
import Foundation
import UIKit

class WKDetailButtonView: WKComponentView {
    
    struct Configuration {
        let typeText: String
        let selectionText: String
    }
    
    lazy var typeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var selectionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    lazy var disclosureImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = WKIcon.chevonRight
        return imageView
    }()
    
    private var configuration: Configuration?
    
    required init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(typeLabel)
        addSubview(selectionLabel)
        addSubview(disclosureImageView)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: selectionLabel.leadingAnchor),
            selectionLabel.trailingAnchor.constraint(equalTo: disclosureImageView.leadingAnchor),
            trailingAnchor.constraint(equalTo: disclosureImageView.trailingAnchor),
            topAnchor.constraint(equalTo: typeLabel.topAnchor),
            bottomAnchor.constraint(equalTo: typeLabel.bottomAnchor)
        ])
    }
    
    func configure(configuration: Configuration) {
        typeLabel.text = configuration.typeText
        selectionLabel.text = configuration.selectionText
    }
}
