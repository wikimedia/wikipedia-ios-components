import UIKit

enum WKFont {

	case body
	case largeButton
	case smallButton
	case prominentTitle
	case headline
	case smallHeadline
	case prominentHeadline
	case caption

	static func `for`(_ font: WKFont, compatibleWith traitCollection: UITraitCollection = WKAppEnvironment.current.traitCollection) -> UIFont {
		switch font {
		case .body:
			return UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
		case .largeButton:
			return UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: traitCollection)
		case .smallButton:
			return UIFont.preferredFont(forTextStyle: .callout, compatibleWith: traitCollection)
		case .prominentTitle:
			return UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.systemFont(ofSize: 32, weight: .heavy), compatibleWith: traitCollection)
		case .headline:
			return UIFont.preferredFont(forTextStyle: .headline, compatibleWith: traitCollection)
		case .smallHeadline:
			return UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: traitCollection)
		case .prominentHeadline:
			return UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 24, weight: .heavy), maximumPointSize: 32, compatibleWith: traitCollection)
		case .caption:
			return UIFont.preferredFont(forTextStyle: .callout, compatibleWith: traitCollection)
		}
	}

}
