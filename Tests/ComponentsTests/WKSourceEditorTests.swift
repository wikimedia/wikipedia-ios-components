import XCTest
@testable import Components

final class WKSourceEditorTests: XCTestCase {
    
    var textView: UITextView!
    var editorView: WKSourceEditorView!
    var editorViewController: WKSourceEditorViewController!
    
    override func setUpWithError() throws {
        let viewModel = WKSourceEditorViewModel(configuration: .full, initialText: "Testing Wikitext", localizedStrings: WKSourceEditorLocalizedStrings.testStrings)
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

extension WKSourceEditorLocalizedStrings {
    static var testStrings: WKSourceEditorLocalizedStrings {
        return WKSourceEditorLocalizedStrings(
            inputViewTextFormatting: "Text Formatting",
            inputViewStyle: "Style",
            inputViewClearFormatting: "Clear Formatting",
            inputViewParagraph: "Paragraph",
            inputViewHeading: "Heading",
            inputViewSubheading1: "Sub-heading 1",
            inputViewSubheading2: "Sub-heading 2",
            inputViewSubheading3: "Sub-heading 3",
            inputViewSubheading4: "Sub-heading 4",
            findReplaceTypeSingle: "Replace",
            findReplaceTypeAll: "Replace All",
            findReplaceWith: "Replace with..."
            )
    }
}
