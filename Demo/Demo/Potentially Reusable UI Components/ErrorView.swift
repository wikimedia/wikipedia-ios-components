import Foundation
import UIKit

class ErrorView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
}
