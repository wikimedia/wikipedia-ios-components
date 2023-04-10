
import Foundation
import UIKit

class WKDestructiveButtonView: WKComponentView {
    
    struct Configuration {
        let text: String
    }
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        label.text = configuration.text
    }
}
