
import Foundation
import UIKit

class WKEditorSelectionDetailView: WKComponentView {
    
    // MARK: - Properties
    
    private lazy var typeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var selectionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var disclosureImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = WKIcon.chevronRight
        return imageView
    }()
    
    private var viewModel: WKEditorSelectionDetailViewModel?
    
    // MARK: - Lifecycle
    
    required init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 22, bottom: 8, trailing: 22)
        
        addSubview(typeLabel)
        addSubview(selectionLabel)
        addSubview(disclosureImageView)
        NSLayoutConstraint.activate([
            layoutMarginsGuide.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: disclosureImageView.trailingAnchor),
            layoutMarginsGuide.topAnchor.constraint(equalTo: typeLabel.topAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: typeLabel.bottomAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: selectionLabel.leadingAnchor),
            selectionLabel.trailingAnchor.constraint(equalTo: disclosureImageView.leadingAnchor, constant: -8),
            selectionLabel.centerYAnchor.constraint(equalTo: disclosureImageView.centerYAnchor),
            selectionLabel.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor),
        ])
    }
    
    // MARK: - Internal
    
    func configure(viewModel: WKEditorSelectionDetailViewModel) {
        typeLabel.text = viewModel.typeText
        selectionLabel.text = viewModel.selectionText
    }
}
