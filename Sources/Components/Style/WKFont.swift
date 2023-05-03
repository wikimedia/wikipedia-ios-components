import UIKit

enum WKFont {

	case body

	static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> UIFont {
		switch font {
		case .body:
			return UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
		}
	}

}
