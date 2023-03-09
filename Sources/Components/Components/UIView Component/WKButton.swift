import UIKit
import Combine

public final class WKButton: WKComponentView {

	// MARK: - Nested Types

	public enum Configuration {
		case large(text: String)
		case small(text: String)
	}

	// MARK: - Private Properties

	private let button: UIButton!
	private let configuration: Configuration!

	// MARK: - Lifecycle

	public required init(configuration: Configuration) {
		button = UIButton(type: .custom)
		self.configuration = configuration
		super.init(frame: .zero)
		setup()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Component Conformance

	private func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		button.translatesAutoresizingMaskIntoConstraints = false
		addSubview(button)
		NSLayoutConstraint.activate([
			button.leadingAnchor.constraint(equalTo: leadingAnchor),
			button.trailingAnchor.constraint(equalTo: trailingAnchor),
			button.topAnchor.constraint(equalTo: topAnchor),
			button.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
		configure()
	}

	private func configure() {
		switch configuration {
		case .large(text: let text):
			button.setTitle(text, for: .normal)
			button.setTitleColor(theme == WKTheme.dark ? theme.primaryText : theme.background, for: .normal)
			button.titleLabel?.font = WKFont.for(.largeButton, compatibleWith: appEnvironment.traitCollection)
			button.backgroundColor = theme.buttonBackground
			button.layer.cornerRadius = 16
		case .small(text: let text):
			button.setTitle(text, for: .normal)
			button.setTitleColor(theme.primaryText, for: .normal)
			button.titleLabel?.font = WKFont.for(.smallButton, compatibleWith: appEnvironment.traitCollection)
			button.backgroundColor = theme.secondaryButtonBackground
		default:
			break
		}
	}

	override public func appEnvironmentDidChange() {
		configure()
	}

	// MARK: - Public Actions

	public func addTarget(_ target: Any?, action: Selector, for controlEvent: UIControl.Event) {
		button.addTarget(target, action: action, for: controlEvent)
	}

	public func removeTarget(_ target: Any?, action: Selector?, for controlEvent: UIControl.Event) {
		button.removeTarget(target, action: action, for: controlEvent)
	}

}
