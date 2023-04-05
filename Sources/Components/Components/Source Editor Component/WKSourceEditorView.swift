import Foundation
import UIKit
import ComponentsObjC

class WKSourceEditorView: WKComponentView {
    
    public typealias Configuration = WKSourceEditorViewModel.Configuration
    
    // MARK: - UI Elements
    
    lazy var textView: UITextView = {
        
        let textStorage = WKSourceEditorTextStorage()

        let layoutManager = NSLayoutManager()
        let container = NSTextContainer()
        
        container.widthTracksTextView = true
        
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)

        let textView = UITextView(frame: bounds, textContainer: container)
        
        textView.textContainerInset = .init(top: 16, left: 8, bottom: 16, right: 8)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.smartQuotesType = .no
        textView.smartDashesType = .no
        textView.keyboardDismissMode = .interactive
        
        return textView
    }()
    
    // MARK: - Properties
    
    private let configuration: Configuration

    required init(configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setup()
    }
    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(textView)

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            topAnchor.constraint(equalTo: textView.topAnchor),
            bottomAnchor.constraint(equalTo: textView.bottomAnchor)
        ])
    }
}
