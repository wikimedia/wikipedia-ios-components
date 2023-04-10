import Foundation
import UIKit

class WKSimpleSelectionView: WKComponentView {
    
    enum HeadingLevel {
        case h2
        case h3
        case h4
        case h5
        case h6
    }
    
    struct Configuration {
        let headingLevel: HeadingLevel
        let isSelected: Bool
    }
    
    private var configuration: Configuration?
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header item"
        return label
    }()
    
    required init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(label)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: label.leadingAnchor),
            trailingAnchor.constraint(equalTo: label.trailingAnchor),
            topAnchor.constraint(equalTo: label.topAnchor),
            bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }
    
    func configure(configuration: Configuration) {
        
    }
}
