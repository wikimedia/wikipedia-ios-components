import UIKit

enum WKFont {

    case headline
	case body
    case caption1

	static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> UIFont {
		switch font {
        case .headline:
            return UIFont.preferredFont(forTextStyle: .headline, compatibleWith: traitCollection)
		case .body:
			return UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
        case .caption1:
            return UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: traitCollection)
		}
	}
}
