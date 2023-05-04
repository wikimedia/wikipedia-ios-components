import Foundation
import UIKit

public protocol WKSourceEditorViewControllerDelegate: AnyObject {
    func sourceEditorViewControllerDidTapFind(sourceEditorViewController: WKSourceEditorViewController)
}

public class WKSourceEditorViewController: WKComponentViewController {
    
    // MARK: - Properties
    
    let viewModel: WKSourceEditorViewModel
    private weak var delegate: WKSourceEditorViewControllerDelegate?
    
    var editorView: WKSourceEditorView {
        return view as! WKSourceEditorView
    }
    
    // MARK: - Lifecycle
    
    public init(viewModel: WKSourceEditorViewModel, delegate: WKSourceEditorViewControllerDelegate, strings: WKEditorLocalizedStrings) {
        self.delegate = delegate
        WKEditorLocalizedStrings.shared = strings
        self.viewModel = viewModel
        super.init()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = WKSourceEditorView(isSyntaxHighlightingEnabled: viewModel.isSyntaxHighlightingEnabled, delegate: self)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        editorView.setInitialText(viewModel.initialText)
        editorView.inputAccessoryViewType = .expanding
    }
    
    // MARK: - Public
    
    public func closeFind() {
        editorView.closeFind()
        editorView.inputAccessoryViewType = .expanding
    }
    
    public func disableSyntaxHighlighting() {
        viewModel.isSyntaxHighlightingEnabled = false
        editorView.setIsSyntaxHighlightingEnabled(false)
    }
    
    public func enableSyntaxHighlighting() {
        viewModel.isSyntaxHighlightingEnabled = true
        editorView.setIsSyntaxHighlightingEnabled(true)
    }
    
// MARK: Private
    
    private func updateButtonSelectionStates(withDelay: Bool) {
        if withDelay {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                guard let self = self else {
                    return
                }
                NotificationCenter.default.post(name: Notification.sourceEditorUpdateButtonSelectionStates, object: nil, userInfo: [String.WKSourceEditorButtonSelectionStatesKey: self.editorView.inputButtonSelectionStates])
            }
        } else {
            NotificationCenter.default.post(name: Notification.sourceEditorUpdateButtonSelectionStates, object: nil, userInfo: [String.WKSourceEditorButtonSelectionStatesKey: editorView.inputButtonSelectionStates])
        }
    }
}

extension WKSourceEditorViewController: WKSourceEditorViewDelegate {
    func editorViewDidTapBold(editorView: WKSourceEditorView) {
        editorView.addOrRemoveBoldFormattingFromSelectedText()
    }
    
    func editorViewDidTapItalics(editorView: WKSourceEditorView) {
        editorView.addOrRemoveItalicsFormattingFromSelectedText()
    }
    
    func editorViewTextSelectionDidChange(editorView: WKSourceEditorView, isRangeSelected: Bool) {
        guard editorView.inputViewType == nil else {
            updateButtonSelectionStates(withDelay: false)
            return
        }
        
        editorView.inputAccessoryViewType = isRangeSelected ? .highlight : .expanding
        updateButtonSelectionStates(withDelay: false)
    }
    
    func editorViewDidTapFind(editorView: WKSourceEditorView) {
        editorView.inputAccessoryViewType = .find
        delegate?.sourceEditorViewControllerDidTapFind(sourceEditorViewController: self)
    }
    
    func editorViewDidTapFormatText(editorView: WKSourceEditorView) {
        editorView.inputViewType = .main
        updateButtonSelectionStates(withDelay: true)
    }
    
    func editorViewDidTapFormatHeading(editorView: WKSourceEditorView) {
        editorView.inputViewType = .headerSelect
    }
    
    func editorViewDidTapCloseInputView(editorView: WKSourceEditorView, isRangeSelected: Bool) {
        editorView.inputViewType = nil
        editorView.inputAccessoryViewType = isRangeSelected ? .highlight : .expanding
    }
    
    func editorViewDidTapShowMore(editorView: WKSourceEditorView) {
        editorView.inputViewType = .main
        updateButtonSelectionStates(withDelay: true)
    }
}
