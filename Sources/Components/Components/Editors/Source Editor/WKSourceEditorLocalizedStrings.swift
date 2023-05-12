import Foundation

public struct WKSourceEditorLocalizedStrings {
    
    static var current: WKSourceEditorLocalizedStrings!
    
    let inputViewTextFormatting: String
    let inputViewStyle: String
    let inputViewClearFormatting: String
    let inputViewParagraph: String
    let inputViewHeading: String
    let inputViewSubheading1: String
    let inputViewSubheading2: String
    let inputViewSubheading3: String
    let inputViewSubheading4: String
    let findReplaceTypeSingle: String
    let findReplaceTypeAll: String
    let findReplaceWith: String
    
    public init(inputViewTextFormatting: String, inputViewStyle: String, inputViewClearFormatting: String, inputViewParagraph: String, inputViewHeading: String, inputViewSubheading1: String, inputViewSubheading2: String, inputViewSubheading3: String, inputViewSubheading4: String, findReplaceTypeSingle: String, findReplaceTypeAll: String, findReplaceWith: String) {
        self.inputViewTextFormatting = inputViewTextFormatting
        self.inputViewStyle = inputViewStyle
        self.inputViewClearFormatting = inputViewClearFormatting
        self.inputViewParagraph = inputViewParagraph
        self.inputViewHeading = inputViewHeading
        self.inputViewSubheading1 = inputViewSubheading1
        self.inputViewSubheading2 = inputViewSubheading2
        self.inputViewSubheading3 = inputViewSubheading3
        self.inputViewSubheading4 = inputViewSubheading4
        self.findReplaceTypeSingle = findReplaceTypeSingle
        self.findReplaceTypeAll = findReplaceTypeAll
        self.findReplaceWith = findReplaceWith
    }
}
