import Foundation
import UIKit
import UIComponents

class AppViewController: UITabBarController, Themeable, ThemeableNavigationControllerDelegate {

    lazy var featureStartVC: FeatureStartViewController = {
        let vc = FeatureStartViewController(theme: theme)
        vc.title = "Feature"
        vc.tabBarItem.image = UIImage(systemName: "lightbulb")
        return vc
    }()
    
    lazy var settingsVC: SettingsViewController = {
        let vc = SettingsViewController(nibName: nil, bundle: nil)
        vc.title = "Settings"
        vc.tabBarItem.image = UIImage(systemName: "gearshape")
        return vc
    }()
    
    private var theme: Theme = .standard
    
    // MARK: Lifecycle
    
    func launchApp(in window: UIWindow) {
        let rootNavigationController = ThemeableNavigationController(theme: theme, rootViewController: self)
        rootNavigationController.themeableNavigationControllerDelegate = self
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        updateUserInterfaceStyleOfViewControllerForCurrentTheme(rootNavigationController)
        loadMainUI()
    }
    
    private func loadMainUI() {
        configureTabController()
        apply(theme: theme)
    }
    
    private func configureTabController() {
        self.viewControllers = [featureStartVC, settingsVC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.theme = UserDefaults.standard.theme(compatibleWith: traitCollection)
        NotificationCenter.default.addObserver(self, selector: #selector(userDidChangeTheme), name: Notification.Name.WMFUserDidSelectThemeNotification, object: nil)
    }
    
    // MARK: Notifications
    
    @objc private func userDidChangeTheme(_ notification: Notification) {
        guard let themeName = notification.userInfo?[NSNotification.UserInfoKeys.WMFUserDidSelectThemeNotificationThemeNameKey] as? String else {
            return
        }
        
        UserDefaults.standard.themeName = themeName
        updateUserInterfaceStyleOfViewControllerForCurrentTheme(navigationController)
        updateAppThemeIfNecessary()
    }
    
    // MARK: Theming
    
    private func updateAppThemeIfNecessary() {
        let theme = UserDefaults.standard.theme(compatibleWith: navigationController?.traitCollection)
        
        if self.theme != theme {
            self.apply(theme: theme)
        }
    }
    
    private func updateUserInterfaceStyleOfViewControllerForCurrentTheme(_ viewController: UIViewController?) {
        
        guard let viewController else {
            return
        }
        
        let themeName = UserDefaults.standard.themeName
        if Theme.isDefaultThemeName(themeName) {
            viewController.overrideUserInterfaceStyle = .unspecified
        } else if Theme.isDarkThemeName(themeName) {
            viewController.overrideUserInterfaceStyle = .dark
        } else {
            viewController.overrideUserInterfaceStyle = .light
        }
    }
    
    func apply(theme: Theme) {
        self.theme = theme
        view.backgroundColor = theme.colors.baseBackground
        featureStartVC.apply(theme: theme)
        settingsVC.apply(theme: theme)
        apply(theme: theme, to: allNavigationControllers())
        tabBar.apply(theme: theme)
    }
    
    func traitCollectionDidChange(_ themeableNavigationController: ThemeableNavigationController) {
        updateAppThemeIfNecessary()
    }
    
    func allNavigationControllers() -> [UINavigationController] {
        if let navVC = navigationController {
            return [navVC]
        }
        
        return []
    }
    
    func apply(theme: Theme, to navigationControllers: [UINavigationController]) {
        
        var foundNavigationControllers: Set<UINavigationController> = []
        
        for navVC in navigationControllers {
            for vc in navVC.viewControllers {
                if let themeableVC = vc as? Themeable,
                   vc != self {
                    themeableVC.apply(theme: theme)
                }
                
                if let presentedNavVC = vc.presentedViewController as? UINavigationController {
                    foundNavigationControllers.insert(presentedNavVC)
                }
            }
            
            if let presentedNavVC = navVC.presentedViewController as? UINavigationController {
                foundNavigationControllers.insert(presentedNavVC)
            }
            
            if let themeableNavVC = navVC as? Themeable {
                themeableNavVC.apply(theme: theme)
            }
        }
        
        if foundNavigationControllers.count > 0 {
            apply(theme: theme, to: Array(foundNavigationControllers))
        }
    }
}
