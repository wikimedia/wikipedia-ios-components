import Foundation
import UIKit
import ComponentsObjC

class WKSourceEditorView: WKComponentView {
    
    public typealias Configuration = WKSourceEditorViewModel.Configuration
    
    // MARK: Nested Types
    
    enum InputViewType {
        case textFormatting
        case textStyle
    }
    
    enum InputAccessoryViewType {
        case standard
        case highlight
        case findInPage
    }
    
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
    
    lazy var standardAccessoryView: UIView = {
        let view = UINib(nibName: "WKStandardEditToolbarView", bundle: Bundle.module).instantiate(withOwner: nil).first as! WKStandardEditToolbarView
        
        return view
    }()
    
    lazy var highlightAccessoryView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 44))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Highlight"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            view.topAnchor.constraint(equalTo: label.topAnchor),
            view.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
        
        return view
    }()
    
    lazy var findInPageAccessoryView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 44))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Find in page"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            view.topAnchor.constraint(equalTo: label.topAnchor),
            view.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
        
        return view
    }()
    
    lazy var formattingInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Formatting"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            view.topAnchor.constraint(equalTo: label.topAnchor),
            view.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
        
        return view
    }()
    
    lazy var styleInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Style"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            view.topAnchor.constraint(equalTo: label.topAnchor),
            view.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
        
        return view
    }()
    
    // MARK: - Properties
    
    private let configuration: Configuration
    var inputViewType: InputViewType? = nil {
        didSet {
            guard let inputViewType else {
                textView.inputView = nil
                return
            }
            
            switch inputViewType {
            case .textFormatting:
                textView.inputView = formattingInputView
            case .textStyle:
                textView.inputView = styleInputView
            }
            
            textView.inputAccessoryView = nil
            textView.reloadInputViews()
        }
    }
    var inputAccessoryViewType: InputAccessoryViewType? = nil {
        didSet {
            guard let inputAccessoryViewType else {
                textView.inputAccessoryView = nil
                return
            }
            
            switch inputAccessoryViewType {
            case .standard:
                textView.inputAccessoryView = standardAccessoryView
            case .highlight:
                textView.inputAccessoryView = highlightAccessoryView
            case .findInPage:
                textView.inputAccessoryView = findInPageAccessoryView
            }
            
            textView.inputView = nil
            textView.reloadInputViews()
        }
    }
    
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
