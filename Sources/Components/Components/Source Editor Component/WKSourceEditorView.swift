import Foundation
import UIKit
import ComponentsObjC

protocol WKSourceEditorViewDelegate: AnyObject {
    func editorViewTextSelectionDidChange(editorView: WKSourceEditorView, isRangeSelected: Bool)
    func editorViewDidTapFind(editorView: WKSourceEditorView)
    func editorViewDidTapFormatText(editorView: WKSourceEditorView)
    func editorViewDidTapFormatHeading(editorView: WKSourceEditorView)
    func editorViewDidTapCloseInputView(editorView: WKSourceEditorView, isRangeSelected: Bool)
    func editorViewDidTapShowMore(editorView: WKSourceEditorView)
}

class WKSourceEditorView: WKComponentView {
    
    // MARK: Nested Types
    
    enum InputViewType {
        case main
        case headerSelect
    }
    
    enum InputAccessoryViewType {
        case expanding
        case highlight
        case find
    }
    
    // MARK: - UI Elements
    
    private lazy var textView: UITextView = {
        
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
        
        // Note: Disabling the suggestions bar prevents console keyboard constraint errors from appearing when switching input views or first responders (this seems like an Apple bug).
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var expandingAccessoryView: WKEditorToolbarExpandingView = {
        let view = UINib(nibName: String(describing: WKEditorToolbarExpandingView.self), bundle: Bundle.module).instantiate(withOwner: nil).first as! WKEditorToolbarExpandingView
        view.delegate = self
        return view
    }()
    
    private lazy var highlightAccessoryView: WKEditorToolbarContextualHighlightView = {
        let view = UINib(nibName: String(describing: WKEditorToolbarContextualHighlightView.self), bundle: Bundle.module).instantiate(withOwner: nil).first as! WKEditorToolbarContextualHighlightView
        view.delegate = self
        
        return view
    }()
    
    private lazy var findAccessoryView: WKFindAndReplaceView = {
        let view = UINib(nibName: String(describing: WKFindAndReplaceView.self), bundle: Bundle.module).instantiate(withOwner: nil).first as! WKFindAndReplaceView
        
        return view
    }()
    
    private var _mainInputView: UIView?
    private var mainInputView: UIView? {
        get {
            guard _mainInputView == nil else {
                return _mainInputView
            }
            
            let inputViewController = WKEditorInputViewController(configuration: .rootMain, delegate: self)
            inputViewController.loadViewIfNeeded()
            
            _mainInputView = inputViewController.view
           
            return inputViewController.view
        }
        set {
            _mainInputView = newValue
        }
    }
    
    private var _headerSelectionInputView: UIView?
    private var headerSelectionInputView: UIView? {
        get {
            guard _headerSelectionInputView == nil else {
                return _headerSelectionInputView
            }
            
            let inputViewController = WKEditorInputViewController(configuration: .rootHeaderSelect, delegate: self)
            inputViewController.loadViewIfNeeded()
            
            _headerSelectionInputView = inputViewController.view
            
           return inputViewController.view
        }
        set {
            _headerSelectionInputView = newValue
        }
    }
    
    // MARK: - Properties

    private weak var delegate: WKSourceEditorViewDelegate?
    
    // MARK: - Lifecycle

    required init(delegate: WKSourceEditorViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
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
    
    // MARK: - Public
    
    func setText(text: String) {
        textView.attributedText = NSAttributedString(string: text)
    }
    
    var text: String {
        return textView.text
    }
    
    var inputViewType: InputViewType? = nil {
        didSet {
            guard let inputViewType else {
                mainInputView = nil
                headerSelectionInputView = nil
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
            case .find:
                textView.inputAccessoryView = findAccessoryView
            }
            
            textView.inputView = nil
            textView.reloadInputViews()
        }
    }
    
    func closeFind() {
        findAccessoryView.close()
        textView.becomeFirstResponder()
    }
    
    // MARK: - Private
    
    private func updateInsets(keyboardHeight: CGFloat) {
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        textView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
}

extension WKSourceEditorView: WKEditorInputViewDelegate {
    func didTapClose() {
        delegate?.editorViewDidTapCloseInputView(editorView: self, isRangeSelected: textView.selectedRange.length > 0)
    }
}

extension WKSourceEditorView: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        delegate?.editorViewTextSelectionDidChange(editorView: self, isRangeSelected: textView.selectedRange.length > 0)
    }
}

extension WKSourceEditorView: WKEditorToolbarExpandingViewDelegate {
    func toolbarExpandingViewDidTapFind(toolbarExpandingView: WKEditorToolbarExpandingView) {
        delegate?.editorViewDidTapFind(editorView: self)
    }
    
    func toolbarExpandingViewDidTapFormatText(toolbarExpandingView: WKEditorToolbarExpandingView) {
        delegate?.editorViewDidTapFormatText(editorView: self)
    }
    
    func toolbarExpandingViewDidTapFormatHeading(toolbarExpandingView: WKEditorToolbarExpandingView) {
        delegate?.editorViewDidTapFormatHeading(editorView: self)
    }
}

extension WKSourceEditorView: WKEditorToolbarContextualHighlightViewDelegate {
    func toolbarContextualHighlightViewDidTapShowMore(toolbarExpandingView: WKEditorToolbarContextualHighlightView) {
        delegate?.editorViewDidTapShowMore(editorView: self)
    }
    
    func toolbarContextualHighlightViewDidTapFormatHeading(toolbarExpandingView: WKEditorToolbarContextualHighlightView) {
        delegate?.editorViewDidTapFormatHeading(editorView: self)
    }
}
