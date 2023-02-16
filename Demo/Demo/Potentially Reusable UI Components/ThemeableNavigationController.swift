import Foundation
import UIKit
import UIComponents

protocol ThemeableNavigationControllerDelegate: AnyObject {
    func traitCollectionDidChange(_ themeableNavigationController: ThemeableNavigationController)
}

class ThemeableNavigationController: UINavigationController, Themeable {
    
    let theme: Theme
    weak var themeableNavigationControllerDelegate: ThemeableNavigationControllerDelegate?
    
    init(theme: Theme, rootViewController: UIViewController) {
        self.theme = theme
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        themeableNavigationControllerDelegate?.traitCollectionDidChange(self)
    }
    
    func apply(theme: Theme) {
        navigationBar.isTranslucent = false
        navigationBar.tintColor = theme.colors.text
        let appearance = UINavigationBarAppearance.appearanceForTheme(theme)
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        
        self.navigationBar.barTintColor = theme.colors.chromeBackground
        view.tintColor = theme.colors.link
        setNeedsStatusBarAppearanceUpdate()
    }
    
}
