import UIKit
import Components

final class MenuButtonViewController: WKCanvasViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let buttonConfiguration1 = WKMenuButton.Configuration(
			title: "Username",
			image: UIImage(systemName: "person.fill"),
			primaryColor: \.link,
			menuItems: [
				WKMenuButton.MenuItem(title: "User page", image: UIImage(systemName: "person.fill")),
				WKMenuButton.MenuItem(title: "Talk page", image: UIImage(systemName: "bubble.left.and.bubble.right")),
				WKMenuButton.MenuItem(title: "User contributions", image: UIImage(systemName: "person.text.rectangle"))
			]
		)

		let buttonConfiguration2 = WKMenuButton.Configuration(
			title: "Username",
			image: UIImage(systemName: "person.fill"),
			primaryColor: \.diffCompareAccent,
			menuItems: [
				WKMenuButton.MenuItem(title: "User page", image: UIImage(systemName: "person.fill")),
				WKMenuButton.MenuItem(title: "Talk page", image: UIImage(systemName: "bubble.left.and.bubble.right")),
				WKMenuButton.MenuItem(title: "User contributions", image: UIImage(systemName: "person.text.rectangle"))
			]
		)

		let button1 = WKMenuButton(configuration: buttonConfiguration1)
		button1.delegate = self
		canvas.addSubview(button1)

		let button2 = WKMenuButton(configuration: buttonConfiguration2)
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

	func wkMenuButton(_ sender: WKMenuButton, didTapMenuItem item: WKMenuButton.MenuItem) {
		print("User tapped: \(sender) \t menu item \(item.id)")
	}

}
