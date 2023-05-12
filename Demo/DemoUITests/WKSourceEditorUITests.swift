import XCTest
@testable import Demo

final class WKSourceEditorUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSourceEditorInputViewSwitching() throws {
        let app = XCUIApplication()
        app.launchArguments += ProcessInfo().arguments
        app.launch()
        
        app.buttons[DemoSourceEditorAccessibilityIdentifiers.entryButton.rawValue].tap()
        let textView = app.textViews[DemoSourceEditorAccessibilityIdentifiers.textView.rawValue]
        textView.tap()
        textView.typeText("Hello World!")
        
        XCTAssertFalse(app.isDisplayingMainInputView)
        XCTAssertFalse(app.isDisplayingHeaderSelectView)
        XCTAssertTrue(app.isDisplayingExpandingToolbar)
        XCTAssertFalse(app.isDisplayingHighlightingToolbar)
        XCTAssertFalse(app.isDisplayingFindAndReplaceToolbar)
        
        let initialAttachment = XCTAttachment(screenshot: app.screenshot())
        initialAttachment.name = ScreenshotNames.initial.rawValue
        add(initialAttachment)
        
        textView.doubleTap()
        
        XCTAssertFalse(app.isDisplayingMainInputView)
        XCTAssertFalse(app.isDisplayingHeaderSelectView)
        XCTAssertFalse(app.isDisplayingExpandingToolbar)
        XCTAssertTrue(app.isDisplayingHighlightingToolbar)
        XCTAssertFalse(app.isDisplayingFindAndReplaceToolbar)
        
        let highlightAttachment = XCTAttachment(screenshot: app.screenshot())
        highlightAttachment.name = ScreenshotNames.highlighted.rawValue
        add(highlightAttachment)
        
        app.buttons[DemoSourceEditorAccessibilityIdentifiers.showMoreButton.rawValue].tap()
        
        XCTAssertTrue(app.isDisplayingMainInputView)
        XCTAssertFalse(app.isDisplayingHeaderSelectView)
        XCTAssertFalse(app.isDisplayingExpandingToolbar)
        XCTAssertFalse(app.isDisplayingHighlightingToolbar)
        XCTAssertFalse(app.isDisplayingFindAndReplaceToolbar)
        
        app.buttons[DemoSourceEditorAccessibilityIdentifiers.closeButton.rawValue].tap()

        textView.typeText("Adding text to remove selection.")
        
        app.buttons[DemoSourceEditorAccessibilityIdentifiers.formatTextButton.rawValue].tap()
        
        XCTAssertTrue(app.isDisplayingMainInputView)
        XCTAssertFalse(app.isDisplayingHeaderSelectView)
        XCTAssertFalse(app.isDisplayingExpandingToolbar)
        XCTAssertFalse(app.isDisplayingHighlightingToolbar)
        XCTAssertFalse(app.isDisplayingFindAndReplaceToolbar)
        
        let mainInputViewAttachment = XCTAttachment(screenshot: app.screenshot())
        mainInputViewAttachment.name = ScreenshotNames.main.rawValue
        add(mainInputViewAttachment)
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 2).tap()
        
        XCTAssertFalse(app.isDisplayingMainInputView)
        XCTAssertTrue(app.isDisplayingHeaderSelectView)
        XCTAssertFalse(app.isDisplayingExpandingToolbar)
        XCTAssertFalse(app.isDisplayingHighlightingToolbar)
        XCTAssertFalse(app.isDisplayingFindAndReplaceToolbar)
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        let headerSelectInputView1Attachment = XCTAttachment(screenshot: app.screenshot())
        headerSelectInputView1Attachment.name = ScreenshotNames.headerSelect1.rawValue
        add(headerSelectInputView1Attachment)
        
        app.buttons[DemoSourceEditorAccessibilityIdentifiers.closeButton.rawValue].tap()
        
        app.buttons[DemoSourceEditorAccessibilityIdentifiers.formatHeadingButton.rawValue].tap()
        
        XCTAssertFalse(app.isDisplayingMainInputView)
        XCTAssertTrue(app.isDisplayingHeaderSelectView)
        XCTAssertFalse(app.isDisplayingExpandingToolbar)
        XCTAssertFalse(app.isDisplayingHighlightingToolbar)
        XCTAssertFalse(app.isDisplayingFindAndReplaceToolbar)
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 2).tap()
        
        let headerSelectInputView2Attachment = XCTAttachment(screenshot: app.screenshot())
        headerSelectInputView2Attachment.name = ScreenshotNames.headerSelect2.rawValue
        add(headerSelectInputView2Attachment)
        
        app.buttons[DemoSourceEditorAccessibilityIdentifiers.closeButton.rawValue].tap()
        
        app.buttons[DemoSourceEditorAccessibilityIdentifiers.findButton.rawValue].tap()
        
        let findAttachment = XCTAttachment(screenshot: app.screenshot())
        findAttachment.name = ScreenshotNames.find.rawValue
        add(findAttachment)
    }
}

extension XCUIApplication {
    var isDisplayingExpandingToolbar: Bool {
        return otherElements[DemoSourceEditorAccessibilityIdentifiers.expandingToolbar.rawValue].exists
    }
    
    var isDisplayingHighlightingToolbar: Bool {
        return otherElements[DemoSourceEditorAccessibilityIdentifiers.highlightToolbar.rawValue].exists
    }
    
    var isDisplayingFindAndReplaceToolbar: Bool {
        return otherElements[DemoSourceEditorAccessibilityIdentifiers.findToolbar.rawValue].exists
    }
    
    var isDisplayingMainInputView: Bool {
        return otherElements[DemoSourceEditorAccessibilityIdentifiers.mainInputView.rawValue].exists
    }
    
    var isDisplayingHeaderSelectView: Bool {
        return otherElements[DemoSourceEditorAccessibilityIdentifiers.headerSelectInputView.rawValue].exists
    }
}

private enum ScreenshotNames: String {
    case initial = "Source Editor Initial"
    case highlighted = "Source Editor Highlighted"
    case main = "Source Editor Main Input View 1"
    case headerSelect1 = "Source Editor Header Select Input View 1"
    case headerSelect2 = "Source Editor Header Select Input View 2"
    case find = "Source Editor Find"
}
