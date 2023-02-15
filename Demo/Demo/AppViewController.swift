import Foundation
import UIKit
import UIComponents

class AppViewController: UITabBarController, Themeable {

    lazy var featureVC: FeatureViewController = {
        let viewModel = FeatureViewModel(theme: theme)
        let vc = FeatureViewController(viewModel: viewModel)
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
        let rootNavigationController = UINavigationController(rootViewController: self)
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
        self.viewControllers = [featureVC, settingsVC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.theme = UserDefaults.standard.theme(compatibleWith: traitCollection)
        NotificationCenter.default.addObserver(self, selector: #selector(userDidChangeTheme), name: Notification.Name.WMFUserDidSelectThemeNotification, object: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateAppThemeIfNecessary()
    }
    
    // MARK: Notifications
    
    @objc private func userDidChangeTheme(_ notification: Notification) {
        guard let themeName = notification.userInfo?[NSNotification.UserInfoKeys.WMFUserDidSelectThemeNotificationThemeNameKey] as? String else {
            return
        }
        
        UserDefaults.standard.themeName = themeName
        updateAppThemeIfNecessary()
        updateUserInterfaceStyleOfViewControllerForCurrentTheme(navigationController)
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
        featureVC.apply(theme: theme)
        settingsVC.apply(theme: theme)
        tabBar.apply(theme: theme)
    }
}
