import UIKit
import SwiftUI

enum WKFont {

    case headline
    case title
	case body
	case smallBody
	case callout
	case subheadline
	case boldSubheadline
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
		case .boldFootnote:
			guard let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote, compatibleWith: traitCollection).withSymbolicTraits(.traitBold) else {
				fatalError()
			}
			return UIFont(descriptor: descriptor, size: 0)
		}
	}
}
