import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: RootWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		let navigationController = UINavigationController(rootViewController: ViewController())
		window = RootWindow(windowScene: windowScene)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

}

