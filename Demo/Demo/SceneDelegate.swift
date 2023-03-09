import UIKit
import Components

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: RootWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }	

		window = RootWindow(windowScene: windowScene)
		window?.rootViewController = FeatureNavigationController()
		window?.makeKeyAndVisible()
    }

}


