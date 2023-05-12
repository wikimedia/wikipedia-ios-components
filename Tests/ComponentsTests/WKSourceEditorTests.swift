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
            findReplaceWith: "Replace with...",
            accessibilityLabelButtonFormatText: "Show text formatting menu",
            accessibilityLabelButtonFormatHeading: "Show text style menu",
            accessibilityLabelButtonCitation: "Add reference syntax",
            accessibilityLabelButtonCitationSelected: "Remove reference syntax",
            accessibilityLabelButtonLink: "Add link syntax",
            accessibilityLabelButtonLinkSelected: "Remove link syntax",
            accessibilityLabelButtonTemplate: "Add template syntax",
            accessibilityLabelButtonTemplateSelected: "Remove template syntax",
            accessibilityLabelButtonMedia: "Insert media",
            accessibilityLabelButtonFind: "Find in page",
            accessibilityLabelButtonListUnordered: "Make current line unordered list",
            accessibilityLabelButtonListUnorderedSelected: "Remove unordered list from current line",
            accessibilityLabelButtonListOrdered: "Make current line ordered list",
            accessibilityLabelButtonListOrderedSelected: "Remove ordered list from current line",
            accessibilityLabelButtonInceaseIndent: "Increase indent depth",
            accessibilityLabelButtonDecreaseIndent: "Decrease indent depth",
            accessibilityLabelButtonCursorUp: "Move cursor up",
            accessibilityLabelButtonCursorDown: "Move cursor down",
            accessibilityLabelButtonCursorLeft: "Move cursor left",
            accessibilityLabelButtonCursorRight: "Move cursor right",
            accessibilityLabelButtonBold: "Add bold formatting",
            accessibilityLabelButtonBoldSelected: "Remove bold formatting",
            accessibilityLabelButtonItalics: "Add italic formatting",
            accessibilityLabelButtonItalicsSelected: "Remove italic formatting",
            accessibilityLabelButtonClearFormatting: "Clear formatting",
            accessibilityLabelButtonShowMore: "Show text formatting menu", // common with format text buttons
            accessibilityLabelButtonComment: "Add comment syntax",
            accessibilityLabelButtonCommentSelected: "Remove comment syntax",
            accessibilityLabelButtonSuperscript: "Add superscript formatting",
            accessibilityLabelButtonSuperscriptSelected: "Remove superscript formatting",
            accessibilityLabelButtonSubscript: "Add subscript formatting",
            accessibilityLabelButtonSubscriptSelected: "Remove subscript formatting",
            accessibilityLabelButtonUnderline: "Add underline",
            accessibilityLabelButtonUnderlineSelected: "Remove underline",
            accessibilityLabelButtonStrikethrough: "Add strikethrough",
            accessibilityLabelButtonStrikethroughSelected:  "Remove strikethrough",
            accessibilityLabelButtonCloseMainInputView: "Close text formatting menu",
            accessibilityLabelButtonCloseHeaderSelectInputView: "Close text style menu",
            accessibilityLabelFindTextField: "Find",
            accessibilityLabelFindButtonClear: "Clear find",
            accessibilityLabelFindButtonClose: "Close find",
            accessibilityLabelFindButtonNext: "Next find result",
            accessibilityLabelFindButtonPrevious: "Previous find result",
            accessibilityLabelReplaceTextField:  "Replace",
            accessibilityLabelReplaceButtonClear: "Clear replace",
            accessibilityLabelReplaceButtonPerformFormat: "Perform replace operation. Replace type is set to %@",
            accessibilityLabelReplaceButtonSwitchFormat: "Switch replace type. Currently set to %@. Select to change.",
            accessibilityLabelReplaceTypeSingle: "Replace single instance",
            accessibilityLabelReplaceTypeAll: "Replace all instances"
            )
    }
}
