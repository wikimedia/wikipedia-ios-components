import UIKit
import Components

/// The root window for the demo app. Trait collection changes are fed into the Components system here.
final class RootWindow: UIWindow {

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)

		WKAppEnvironment.current.set(theme: traitCollection.userInterfaceStyle == .light ? WKTheme.light : WKTheme.dark, traitCollection: traitCollection)
	}

}
