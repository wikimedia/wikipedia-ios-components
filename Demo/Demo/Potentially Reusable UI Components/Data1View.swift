import Foundation
import UIKit
import Components

class Data1View: UIView, Themeable {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: stackView.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    func configure(items: [Feature1ItemViewModel], theme: Theme) {
        
        for item in items {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontForContentSizeCategory = true
            label.text = item.title
            stackView.addArrangedSubview(label)
        }
        
        apply(theme: theme)
        updateFonts()
    }
    
    func updateFonts() {
        
        for subview in stackView.arrangedSubviews {
            if let label = subview as? UILabel {
                label.font = UIFont.wmf_scaledSystemFont(forTextStyle: .body, weight: .bold, size: 14, maximumPointSize: 32)
            }
        }
    }
    
    func apply(theme: Theme) {
        backgroundColor = theme.colors.baseBackground
        
        for subview in stackView.arrangedSubviews {
            if let label = subview as? UILabel {
                label.textColor = theme.colors.text
            }
        }
    }
}
