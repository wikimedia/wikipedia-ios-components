import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: RootWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

        setupForUITestingIfNecessary()
		window = RootWindow(windowScene: windowScene)
		window?.rootViewController = ViewController()
		window?.makeKeyAndVisible()
	}
    
    private func setupForUITestingIfNecessary() {
        #if DEBUG
        if ProcessInfo().arguments.contains("UITestWKThemeLight") {
            UserDefaults.standard.themeName = "Light"
        } else if ProcessInfo().arguments.contains("UITestWKThemeSepia") {
            UserDefaults.standard.themeName = "Sepia"
        } else if ProcessInfo().arguments.contains("UITestWKThemeDark") {
            UserDefaults.standard.themeName = "Dark"
        } else if ProcessInfo().arguments.contains("UITestWKThemeBlack") {
            UserDefaults.standard.themeName = "Black"
        }
        #endif
    }
}
