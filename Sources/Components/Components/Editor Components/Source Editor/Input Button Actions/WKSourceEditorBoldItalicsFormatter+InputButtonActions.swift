
import Foundation
import ComponentsObjC

extension WKSourceEditorFormatterBoldItalics {
    func addOrRemoveBoldFormatting(shouldAdd: Bool, in textView: UITextView) {
        let formattingString = "'''"
        addOrRemoveFormatting(formattingString: formattingString, shouldAdd: shouldAdd, in: textView)
    }
    
    func addOrRemoveItalicsFormatting(shouldAdd: Bool, in textView: UITextView) {
        let formattingString = "''"
        addOrRemoveFormatting(formattingString: formattingString, shouldAdd: shouldAdd, in: textView)
    }
}
