import UIKit
import SwiftUI

enum WKFont {

    case headline
	case body
    case caption1
	case boldFootnote

	static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> UIFont {
		switch font {
        case .headline:
            return UIFont.preferredFont(forTextStyle: .headline, compatibleWith: traitCollection)
		case .body:
			return UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
        case .caption1:
            return UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: traitCollection)
		case .boldFootnote:
			guard let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote, compatibleWith: traitCollection).withSymbolicTraits(.traitBold) else {
				fatalError()
			}
			return UIFont(descriptor: descriptor, size: 0)
		}

	}

    // This method was added correctlyon the Onboarding modal PR and should be completely replaced when that PR is merged and this PR is updated against main
    static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> Font {

        switch font {
        case .caption1:
            return Font.caption
        default:
            return Font.body
        }
    }
}
