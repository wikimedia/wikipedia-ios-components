import UIKit

public protocol WKUICommunicationUIKitViewDelegate: AnyObject {
	func communicationUserTappedButton(text: String)
}

public final class WKUICommunicationUIKitView: WKComponentView {

	// MARK: - Nested Types

	public enum Configuration {
		case horizontal
		case vertical
	}

	// MARK: - Properties

	private let configuration: Configuration!
	public weak var delegate: WKUICommunicationUIKitViewDelegate?

	// MARK: - UI Elements

	private lazy var label: UILabel = {
		let label = UILabel()
		label.text = "👇 I'm a UIKit view"
		label.textAlignment = .center
		label.adjustsFontForContentSizeCategory = true
		return label
	}()

	private lazy var textField: UITextField = {
		let textField = UITextField()
		textField.text = "UITextField text that will get sent to SwiftUI"
		textField.adjustsFontForContentSizeCategory = true
		textField.textAlignment = .center
		return textField
	}()

	private lazy var button: WKButton = {
		let button = WKButton(configuration: .small(text: "Send Message to SwiftUI View"))
		return button
	}()

	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		return stackView
	}()

	// MARK: - Lifecycle

	public required init(configuration: Configuration) {
		self.configuration = configuration
		super.init(frame: .zero)
		setup()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Component Conformance

	private func setup() {
		addSubview(stackView)

		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(textField)
		stackView.addArrangedSubview(button)

		button.addTarget(self, action: #selector(userDidTapButton), for: .primaryActionTriggered)
		label.font = WKFont.for(.headline, compatibleWith: appEnvironment.traitCollection)
		textField.font = WKFont.for(.body, compatibleWith: appEnvironment.traitCollection)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])

		configure()
	}

	private func configure() {
		backgroundColor = theme.background
		label.textColor = theme.primaryText
		label.backgroundColor = theme.prominentText
		textField.backgroundColor = theme.paperBackground
		stackView.axis = configuration == .vertical ? .vertical : .horizontal
	}

	override public func appEnvironmentDidChange() {
		configure()
	}

	// MARK: - Private

	@objc private func userDidTapButton() {
		delegate?.communicationUserTappedButton(text: textField.text ?? "")
	}

}
