import Foundation
import UIKit

enum WKIcon {
    // SF Symbols
    static let chevonRightCircleFill = UIImage(systemName: "chevron.right.circle.fill")
    static let plusCircleFill = UIImage(systemName: "plus.circle.fill")
    static let checkmark = UIImage(systemName: "checkmark")
    static let chevonRight = UIImage(systemName: "chevron.right")
    static let chevonDown = UIImage(systemName: "chevron.down")
    static let chevonLeft = UIImage(systemName: "chevron.left")
    static let chevonUp = UIImage(systemName: "chevron.up")
    
    // Editor SF Symbols
    static let bold = UIImage(systemName: "bold")
    static let italics = UIImage(systemName: "italic")
    static let link = UIImage(systemName: "link")
    static let media = UIImage(systemName: "photo")
    static let find = UIImage(systemName: "magnifyingglass")
    static let comment = UIImage(systemName: "exclamationmark.circle.fill")
    static let unorderedList = UIImage(systemName: "list.bullet")
    static let orderedList = UIImage(systemName: "list.number")
    static let superscript = UIImage(systemName: "textformat.superscript")
    static let `subscript` = UIImage(systemName: "textformat.subscript")
    static let strikethrough = UIImage(systemName: "strikethrough")
    static let underline = UIImage(systemName: "underline")
    
    // Custom Editor Icons
    static let formatText = UIImage(named: "format-text", in: .module, with: nil)
    static let formatHeading = UIImage(named: "format-heading", in: .module, with: nil)
    static let citation = UIImage(named: "citation", in: .module, with: nil)
    static let template = UIImage(named: "template", in: .module, with: nil)
    static let increaseIndent = UIImage(named: "increase-indent", in: .module, with: nil)
    static let decreaseIndent = UIImage(named: "decrease-indent", in: .module, with: nil)
    static let clearFormatting = UIImage(named: "clear-formatting", in: .module, with: nil)
}
