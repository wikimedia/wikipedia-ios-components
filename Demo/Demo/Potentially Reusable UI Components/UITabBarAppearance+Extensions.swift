import Foundation
import UIKit
import Components

extension UITabBarAppearance {
    static func appearanceForTheme(_ theme: Theme) -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = theme.colors.chromeBackground
        
        let itemAppearance = UITabBarItemAppearance()
        let normalStateAppearance = itemAppearance.normal
        normalStateAppearance.titleTextAttributes = theme.tabBarTitleTextAttributes
        normalStateAppearance.iconColor = theme.colors.unselected
        let selectedStateAppearance = itemAppearance.selected
        selectedStateAppearance.titleTextAttributes = theme.tabBarSelectedTitleTextAttributes
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        return appearance
    }
}
