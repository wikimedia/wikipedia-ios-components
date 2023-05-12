import XCTest
@testable import Components

final class WKSourceEditorTests: XCTestCase {
    
    var textView: UITextView!
    var editorView: WKSourceEditorView!
    var editorViewController: WKSourceEditorViewController!
    
    override func setUpWithError() throws {
        let viewModel = WKSourceEditorViewModel(configuration: .full, initialText: "Testing Wikitext")
        self.editorViewController = WKSourceEditorViewController(viewModel: viewModel, delegate: self)
        editorViewController.loadViewIfNeeded()
        self.editorView = editorViewController.editorView
        self.textView = editorViewController.editorView.textView
    }
    
    func testSourceEditorDefaultInputAccessoryView() {
        textView.becomeFirstResponder()
        XCTAssert(textView.inputAccessoryView is WKEditorToolbarExpandingView)
    }
    
    func testSourceEditorHighlightInputAccessoryView() {
        textView.becomeFirstResponder()
        textView.selectedRange = NSRange(location: 0, length: 7)
        XCTAssert(textView.inputAccessoryView is WKEditorToolbarHighlightView)
    }
    
    func testSourceEditorFindInputAccessoryView() {
        textView.becomeFirstResponder()
        editorViewController.editorViewDidTapFind(editorView: editorView)
        XCTAssert(textView.inputAccessoryView is WKFindAndReplaceView)
        editorViewController.closeFind()
        XCTAssert(textView.inputAccessoryView is WKEditorToolbarExpandingView)
    }
}

extension WKSourceEditorTests: WKSourceEditorViewControllerDelegate {
    func sourceEditorViewControllerDidTapFind(sourceEditorViewController: Components.WKSourceEditorViewController) {
        
    }
}
