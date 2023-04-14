import Foundation
import UIKit
import ComponentsObjC

class WKSourceEditorView: WKComponentView {
    
    // MARK: Nested Types
    
    enum InputViewType {
        case main
        case headerSelect
    }
    
    enum InputAccessoryViewType {
        case expanding
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
    
    lazy var expandingAccessoryView: UIView = {
        let view = UINib(nibName: String(describing: WKEditorToolbarExpandingView.self), bundle: Bundle.module).instantiate(withOwner: nil).first as! UIView
        
        return view
    }()
    
    lazy var highlightAccessoryView: UIView = {
        let view = UINib(nibName: String(describing: WKEditorToolbarContextualHighlightView.self), bundle: Bundle.module).instantiate(withOwner: nil).first as! UIView
        
        return view
    }()
    
    lazy var findInPageAccessoryView: UIView = {
        let view = UINib(nibName: String(describing: WKFindAndReplaceView.self), bundle: Bundle.module).instantiate(withOwner: nil).first as! UIView
        
        return view
    }()
    
    private var _mainInputView: UIView?
    private var mainInputView: UIView {
        
        if let _mainInputView {
            return _mainInputView
        }
        
        let inputViewController = WKEditorInputViewController(configuration: .rootMain, strings: strings)
        inputViewController.delegate = self
        inputViewController.loadViewIfNeeded()
        
        _mainInputView = inputViewController.view
       
        return inputViewController.view
    }
    
    private var _headerSelectionInputView: UIView?
    private var headerSelectionInputView: UIView {
        
        if let _headerSelectionInputView {
            return _headerSelectionInputView
        }
        
        let inputViewController = WKEditorInputViewController(configuration: .rootHeaderSelect, strings: strings)
        inputViewController.delegate = self
        inputViewController.loadViewIfNeeded()
        
        _headerSelectionInputView = inputViewController.view
        
       return inputViewController.view
    }
    
    // MARK: - Properties
    
    private let strings: WKEditorLocalizedStrings
    
    var inputViewType: InputViewType? = nil {
        didSet {
            guard let inputViewType else {
                textView.inputView = nil
                textView.reloadInputViews()
                return
            }
            
            switch inputViewType {
            case .main:
                textView.inputView = mainInputView
            case .headerSelect:
                textView.inputView = headerSelectionInputView
            }
            
            textView.inputAccessoryView = nil
            textView.reloadInputViews()
        }
    }
    var inputAccessoryViewType: InputAccessoryViewType? = nil {
        didSet {
            guard let inputAccessoryViewType else {
                textView.inputAccessoryView = nil
                textView.reloadInputViews()
                return
            }
            
            switch inputAccessoryViewType {
            case .expanding:
                textView.inputAccessoryView = expandingAccessoryView
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

    required init(strings: WKEditorLocalizedStrings) {
        self.strings = strings
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

extension WKSourceEditorView: WKEditorInputViewDelegate {
    func tappedClose() {
        if let inputViewType {
            switch inputViewType {
            case .main:
                _mainInputView = nil
            case .headerSelect:
                _headerSelectionInputView = nil
            }
        }
        
        textView.resignFirstResponder()
        textView.inputView = nil
    }
}
