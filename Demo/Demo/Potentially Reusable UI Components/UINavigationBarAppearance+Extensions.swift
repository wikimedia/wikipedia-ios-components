import Foundation
import UIKit
import Components

extension UINavigationBarAppearance {
    static func appearanceForTheme(_ theme: Theme) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = theme.colors.chromeBackground
        appearance.titleTextAttributes = theme.navigationBarTitleTextAttributes
        appearance.backgroundImage = theme.navigationBarBackgroundImage
        
        return appearance
    }
}
