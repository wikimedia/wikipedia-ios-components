import Foundation
import UIKit

public protocol WKSourceEditorViewControllerDelegate: AnyObject {
    func sourceEditorViewControllerDidTapFind(sourceEditorViewController: WKSourceEditorViewController)
}

public class WKSourceEditorViewController: WKComponentViewController {
    
    // MARK: - Properties
    
    private let viewModel: WKSourceEditorViewModel
    private weak var delegate: WKSourceEditorViewControllerDelegate?
    
    var customView: WKSourceEditorView {
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
        self.view = WKSourceEditorView(delegate: self)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        customView.setText(text: viewModel.wikitext)
        customView.inputAccessoryViewType = .expanding
    }
    
    // MARK: - Public
    
    public func closeFind() {
        customView.closeFind()
        customView.inputAccessoryViewType = .expanding
    }
}

extension WKSourceEditorViewController: WKSourceEditorViewDelegate {
    func editorViewTextSelectionDidChange(editorView: WKSourceEditorView, isRangeSelected: Bool) {
        guard customView.inputViewType == nil else {
            return
        }
        
        customView.inputAccessoryViewType = isRangeSelected ? .highlight : .expanding
    }
    
    func editorViewDidTapFind(editorView: WKSourceEditorView) {
        customView.inputAccessoryViewType = .find
        delegate?.sourceEditorViewControllerDidTapFind(sourceEditorViewController: self)
    }
    
    func editorViewDidTapFormatText(editorView: WKSourceEditorView) {
        customView.inputViewType = .main
    }
    
    func editorViewDidTapFormatHeading(editorView: WKSourceEditorView) {
        customView.inputViewType = .headerSelect
    }
    
    func editorViewDidTapCloseInputView(editorView: WKSourceEditorView, isRangeSelected: Bool) {
        customView.inputViewType = nil
        customView.inputAccessoryViewType = isRangeSelected ? .highlight : .expanding
    }
    
    func editorViewDidTapShowMore(editorView: WKSourceEditorView) {
        customView.inputViewType = .main
    }
}
