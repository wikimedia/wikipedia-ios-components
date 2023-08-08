import UIKit
import SwiftUI

enum WKFont {

    case headline
    case title
	case body
    case subheadline
    case caption1
	case boldFootnote

	static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> UIFont {
		switch font {
        case .headline:
            return UIFont.preferredFont(forTextStyle: .headline, compatibleWith: traitCollection)
        case .title:
            return UIFont.preferredFont(forTextStyle: .title1, compatibleWith: traitCollection)
		case .body:
			return UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
        case .subheadline:
            return UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: traitCollection)
        case .caption1:
            return UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: traitCollection)
		case .boldFootnote:
			guard let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote, compatibleWith: traitCollection).withSymbolicTraits(.traitBold) else {
				fatalError()
			}
			return UIFont(descriptor: descriptor, size: 0)
		}

	}

    static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> Font {
        switch font {
        case .headline:
            return Font.headline
        case .title:
            return Font.title
        case .body:
            return Font.body
        case .subheadline:
            return Font.subheadline
        case .caption1:
            return Font.caption
        case .boldFootnote:
            return Font.footnote.bold()
        }
    }
}
