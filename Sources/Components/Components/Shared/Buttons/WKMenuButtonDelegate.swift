import UIKit

public protocol WKMenuButtonDelegate: AnyObject {
	func wkMenuButton(_ sender: WKMenuButton, didTapMenuItem item: WKMenuButton.MenuItem)
}
