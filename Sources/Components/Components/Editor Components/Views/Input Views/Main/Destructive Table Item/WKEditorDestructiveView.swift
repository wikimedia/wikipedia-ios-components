
import Foundation
import UIKit

class WKEditorDestructiveView: WKComponentView {
    
    struct ViewModel {
        let text: String
    }
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = WKFont.for(.smallButton, compatibleWith: appEnvironment.traitCollection)
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
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 22, bottom: 8, trailing: 22)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            layoutMarginsGuide.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            layoutMarginsGuide.topAnchor.constraint(equalTo: label.topAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        label.text = viewModel.text
    }
}
