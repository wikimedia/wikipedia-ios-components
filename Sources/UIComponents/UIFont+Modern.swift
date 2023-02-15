import Foundation
import UIKit

public extension UIFont {
    class func wmf_scaledSystemFont(forTextStyle style: UIFont.TextStyle, weight: UIFont.Weight, size: CGFloat) -> UIFont {
        return UIFontMetrics(forTextStyle: style).scaledFont(for: UIFont.systemFont(ofSize: size, weight: weight))
    }

    class func wmf_scaledSystemFont(forTextStyle style: UIFont.TextStyle, weight: UIFont.Weight, size: CGFloat, maximumPointSize: CGFloat) -> UIFont {
        return UIFontMetrics(forTextStyle: style).scaledFont(for: UIFont.systemFont(ofSize: size, weight: weight), maximumPointSize: maximumPointSize)
    }
}
