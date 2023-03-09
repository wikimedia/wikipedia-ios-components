import UIKit

public final class WKUICommunicationViewController: WKCanvasViewController, WKUICommunicationUIKitViewDelegate {

	let uiKitView = WKUICommunicationUIKitView(configuration: .vertical)
	let swiftUIHostingController = WKUICommunicationSwiftUIHostingController(data: WKCommunicationData())

	public override func viewDidLoad() {
		super.viewDidLoad()

		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally

		stackView.addArrangedSubview(uiKitView)
		addComponent(swiftUIHostingController, to: stackView)

		view.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
		])

		uiKitView.delegate = self
	}

	public func communicationUserTappedButton(text: String) {
		swiftUIHostingController.data.text = text
		swiftUIHostingController.data.date = Date()
	}

}
