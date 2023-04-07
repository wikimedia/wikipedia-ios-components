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
    
    // MARK: - Lifecycle

    required init(configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            safeAreaLayoutGuide.topAnchor.constraint(equalTo: textView.topAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: textView.bottomAnchor)
        ])
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIApplication.keyboardWillHideNotification,
                                               object: nil)
        
        backgroundColor = .white
    }
    
    // MARK: - Notifications
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        updateInsets(keyboardHeight: 0)
    }

    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let height = max(frame.height - safeAreaInsets.bottom, 0)
            updateInsets(keyboardHeight: height)
        }
    }
    
    // MARK: - Private
    
    private func updateInsets(keyboardHeight: CGFloat) {
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        textView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
}
