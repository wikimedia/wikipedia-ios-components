import Foundation
import UIKit

class WKEditorHeaderSelectView: WKComponentView {
    
    struct ViewModel {
        
        enum Configuration {
            case paragraph
            case heading
            case subheading1
            case subheading2
            case subheading3
            case subheading4
        }
        
        let configuration: Configuration
        let isSelected: Bool
    }
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = WKFont.for(.smallButton, compatibleWith: appEnvironment.traitCollection)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = WKIcon.checkmark
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(imageView)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: label.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            topAnchor.constraint(equalTo: label.topAnchor),
            bottomAnchor.constraint(equalTo: label.bottomAnchor),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        //todo: set font
        imageView.isHidden = viewModel.isSelected
        switch viewModel.configuration {
        case .paragraph:
            label.text = WKEditorLocalizedStrings.shared.inputViewParagraph
        case .heading:
            label.text = WKEditorLocalizedStrings.shared.inputViewHeading
        case .subheading1:
            label.text = WKEditorLocalizedStrings.shared.inputViewSubheading1
        case .subheading2:
            label.text = WKEditorLocalizedStrings.shared.inputViewSubheading2
        case .subheading3:
            label.text = WKEditorLocalizedStrings.shared.inputViewSubheading3
        case .subheading4:
            label.text = WKEditorLocalizedStrings.shared.inputViewSubheading4
        }
    }
}
