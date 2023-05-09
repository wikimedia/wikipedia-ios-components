import Foundation
import Components
import UIKit

extension WKAppEnvironment {
    static func updateWithTraitCollection(_ traitCollection: UITraitCollection) {
        switch UserDefaults.standard.themeName {
        case "Light":
            WKAppEnvironment.current.set(theme: WKTheme.light, traitCollection: traitCollection)
        case "Sepia":
            WKAppEnvironment.current.set(theme: WKTheme.sepia, traitCollection: traitCollection)
        case "Dark":
            WKAppEnvironment.current.set(theme: WKTheme.dark, traitCollection: traitCollection)
        case "Black":
            WKAppEnvironment.current.set(theme: WKTheme.black, traitCollection: traitCollection)
        default:
            WKAppEnvironment.current.set(theme: traitCollection.userInterfaceStyle == .light ? WKTheme.light : WKTheme.black, traitCollection: traitCollection)
        }
    }
}
