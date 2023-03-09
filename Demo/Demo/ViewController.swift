import UIKit
import SwiftUI
import Components

class FeatureNavigationController: WKCanvasViewController, WKFeatureNavigationHostingControllerDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()

		let featureNavigationController = WKFeatureNavigationHostingController(delegate: self)
		addComponent(featureNavigationController, pinToEdges: true, respectSafeArea: true)
	}

	func featureNavigationUserDidTap(_ feature: WKFeature) {
		switch feature {
		case .buttons:
			present(ButtonViewController(nibName: nil, bundle: nil), animated: true)
		case .topRead:
			present(TopReadController(), animated: true)
		case .randomPhoto:
			present(RandomPhotoController(), animated: true)
		case .sayHello:
			present(WKUICommunicationViewController(), animated: true)
		}
	}

}

/// Manually laying out `UIView`-based components on something that isn't a `WKCanvas`. The components react to environment changes but the base `UIView` does not.
class ButtonViewController: UIViewController {

	override func loadView() {
		self.view = UIView()

		view.backgroundColor = .systemOrange

		let largeButton = WKButton(configuration: .large(text: "I'm a large button"))
		let smallButton = WKButton(configuration: .small(text: "I'm a small button"))

		view.addSubview(largeButton)
		view.addSubview(smallButton)

		NSLayoutConstraint.activate([
			largeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
			largeButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
			largeButton.trailingAnchor.constraint(lessThanOrEqualTo: view.readableContentGuide.trailingAnchor),
			smallButton.topAnchor.constraint(equalTo: largeButton.bottomAnchor, constant: 25),
			smallButton.leadingAnchor.constraint(equalTo: largeButton.leadingAnchor),
			smallButton.trailingAnchor.constraint(lessThanOrEqualTo: view.readableContentGuide.trailingAnchor)
		])

	}

}

class TopReadController: WKCanvasViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let topReadController = WKTopReadHostingController(viewModel: WKTopReadViewModel(items: ["these", "are", "some", "top", "read", "items"]))
		addComponent(topReadController, pinToEdges: true)
	}

}

class RandomPhotoController: WKCanvasViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let randomPhotoController = WKRandomPhotoViewController(viewModel: WKRandomPhotoViewModel(configuration: .cats))
		addComponent(randomPhotoController, pinToEdges: true, respectSafeArea: true)
	}
	
}
