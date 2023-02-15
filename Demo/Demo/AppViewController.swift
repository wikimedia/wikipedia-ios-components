import Foundation
import UIKit

class AppViewController: UITabBarController {
    
    lazy var firstVC: UIViewController = {
        let viewModel = FeatureViewModel()
        let vc = FeatureViewController(viewModel: viewModel)
        vc.title = "Feature"
        vc.tabBarItem.image = UIImage(systemName: "lightbulb")
        return vc
    }()
    
    lazy var secondVC: UIViewController = {
        let vc = SettingsViewController(nibName: nil, bundle: nil)
        vc.title = "Settings"
        vc.tabBarItem.image = UIImage(systemName: "gearshape")
        return vc
    }()
    
    func launchApp(in window: UIWindow) {
        let rootNavigationController = UINavigationController(rootViewController: self)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        loadMainUI()
    }
    
    private func loadMainUI() {
        configureTabController()
    }
    
    private func configureTabController() {
        self.viewControllers = [firstVC, secondVC]
    }
}
