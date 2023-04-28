import Foundation
import UIKit

class WKEditorHeaderSelectView: WKComponentView {
    
    class ViewModel {

        enum Configuration {
            case paragraph
            case heading
            case subheading1
            case subheading2
            case subheading3
            case subheading4
        }
        
        let configuration: Configuration
        var isSelected: Bool
        
        init(configuration: WKEditorHeaderSelectView.ViewModel.Configuration, isSelected: Bool) {
            self.configuration = configuration
            self.isSelected = isSelected
        }
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
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 22, bottom: 8, trailing: 22)
        
        addSubview(label)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            layoutMarginsGuide.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            layoutMarginsGuide.topAnchor.constraint(equalTo: label.topAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        imageView.isHidden = !viewModel.isSelected
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
