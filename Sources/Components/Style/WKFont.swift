import UIKit
import SwiftUI

enum WKFont {

    case headline
	case body
    case boldBody
	case smallBody
	case callout
	case subheadline
	case boldSubheadline
    case caption1
    case footnote
	case boldFootnote

	static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> UIFont {
		switch font {
        case .headline:
            return UIFont.preferredFont(forTextStyle: .headline, compatibleWith: traitCollection)
		case .body:
			return UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
        case .boldBody:
            guard let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body, compatibleWith: traitCollection).withSymbolicTraits(.traitBold) else {
                fatalError()
            }
            return UIFont(descriptor: descriptor, size: 0)
		case .smallBody:
			return UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 15, weight: .regular))
		case .callout:
			return UIFont.preferredFont(forTextStyle: .callout, compatibleWith: traitCollection)
		case .subheadline:
			return UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: traitCollection)
		case .boldSubheadline:
			guard let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .subheadline, compatibleWith: traitCollection).withSymbolicTraits(.traitBold) else {
				fatalError()
			}
			return UIFont(descriptor: descriptor, size: 0)
        case .caption1:
            return UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: traitCollection)
        case .footnote:
            return UIFont.preferredFont(forTextStyle: .footnote, compatibleWith: traitCollection)
		case .boldFootnote:
			guard let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote, compatibleWith: traitCollection).withSymbolicTraits(.traitBold) else {
				fatalError()
			}
			return UIFont(descriptor: descriptor, size: 0)
		}
	}

    //the other styles were added on the onboarding PR
    static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> Font {
            switch font {
            case .boldBody:
                return Font.body.bold()
            case .footnote:
                return Font.footnote
            default:
                return Font.body
            }
        }
}
