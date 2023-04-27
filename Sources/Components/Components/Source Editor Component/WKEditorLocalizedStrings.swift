
import Foundation

public struct WKEditorLocalizedStrings {
    let inputViewTextFormatting: String
    let inputViewStyle: String
    let inputViewClearFormatting: String
    let inputViewParagraph: String
    let inputViewHeading: String
    let inputViewSubheading1: String
    let inputViewSubheading2: String
    let inputViewSubheading3: String
    let inputViewSubheading4: String
    
    public init(inputViewTextFormatting: String, inputViewStyle: String, inputViewClearFormatting: String, inputViewParagraph: String, inputViewHeading: String, inputViewSubheading1: String, inputViewSubheading2: String, inputViewSubheading3: String, inputViewSubheading4: String) {
        self.inputViewTextFormatting = inputViewTextFormatting
        self.inputViewStyle = inputViewStyle
        self.inputViewClearFormatting = inputViewClearFormatting
        self.inputViewParagraph = inputViewParagraph
        self.inputViewHeading = inputViewHeading
        self.inputViewSubheading1 = inputViewSubheading1
        self.inputViewSubheading2 = inputViewSubheading2
        self.inputViewSubheading3 = inputViewSubheading3
        self.inputViewSubheading4 = inputViewSubheading4
    }
}

// Assign before first use in feature. Bypasses need to inject strings in all sub-components.
internal extension WKEditorLocalizedStrings {
    static var shared: WKEditorLocalizedStrings!
}
