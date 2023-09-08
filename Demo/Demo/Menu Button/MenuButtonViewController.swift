import UIKit
import SwiftUI
import Components

/// UIKit
final class MenuButtonViewController: WKCanvasViewController {

	static let buttonConfiguration1 = WKMenuButton.Configuration(
		title: "Username",
        image: WKSFSymbolIcon.for(symbol: .personFilled),
		   primaryColor: \.link,
		   menuItems: [
			   WKMenuButton.MenuItem(title: "User page", image: UIImage(systemName: "person.fill")),
			   WKMenuButton.MenuItem(title: "Talk page", image: UIImage(systemName: "bubble.left.and.bubble.right")),
			   WKMenuButton.MenuItem(title: "User contributions", image: UIImage(systemName: "person.text.rectangle"))
		   ]
	   )

	static let buttonConfiguration2 = WKMenuButton.Configuration(
		title: "Username",
		   image: WKSFSymbolIcon.for(symbol: .personFilled),
		   primaryColor: \.diffCompareAccent,
		   menuItems: [
			   WKMenuButton.MenuItem(title: "User page", image: UIImage(systemName: "person.fill")),
			   WKMenuButton.MenuItem(title: "Talk page", image: UIImage(systemName: "bubble.left.and.bubble.right")),
			   WKMenuButton.MenuItem(title: "User contributions", image: UIImage(systemName: "person.text.rectangle"))
		   ]
	   )

	override func viewDidLoad() {
		super.viewDidLoad()

		let button1 = WKMenuButton(configuration: MenuButtonViewController.buttonConfiguration1)
		button1.delegate = self
		canvas.addSubview(button1)

		let button2 = WKMenuButton(configuration: MenuButtonViewController.buttonConfiguration2)
		button2.delegate = self
		canvas.addSubview(button2)

		NSLayoutConstraint.activate([
			button1.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
			button1.centerYAnchor.constraint(equalTo: canvas.centerYAnchor, constant: -50),

			button2.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
			button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 50),
		])
	}

}

extension MenuButtonViewController: WKMenuButtonDelegate {
    func wkMenuButtonDidTap(_ sender: Components.WKMenuButton) {
        print("User tapped menu button: \(sender)")
    }

	func wkMenuButton(_ sender: WKMenuButton, didTapMenuItem item: WKMenuButton.MenuItem) {
		print("User tapped: \(sender) \t menu item \(item.id)")
	}

}

/// SwiftUI
struct SwiftUIMenuButtonView: View {

	var body: some View {
		VStack(spacing: 50) {
			WKSwiftUIMenuButton(configuration: MenuButtonViewController.buttonConfiguration1, menuButtonDelegate: nil)
			WKSwiftUIMenuButton(configuration: MenuButtonViewController.buttonConfiguration2, menuButtonDelegate: nil)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color(WKAppEnvironment.current.theme.paperBackground))
	}

}
