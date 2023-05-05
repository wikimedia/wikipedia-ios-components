
import Foundation
import UIKit

class WKEditorDestructiveView: WKComponentView {

    // MARK: Properties
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Lifecycle
    
    required init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 22, bottom: 8, trailing: 22)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            layoutMarginsGuide.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            layoutMarginsGuide.topAnchor.constraint(equalTo: label.topAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }
    
    // MARK: Internal
    
    func configure(viewModel: WKEditorDestructiveViewModel) {
        label.text = viewModel.text
    }
}
