import SwiftUI

extension Font {

	static func `for`(_ wkFont: WKFont) -> Font {
		return Font(WKFont.for(wkFont))
	}

}
