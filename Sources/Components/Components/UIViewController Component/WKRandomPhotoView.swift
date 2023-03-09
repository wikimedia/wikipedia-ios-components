import UIKit

public class WKRandomPhotoView: WKComponentView {

	public typealias Configuration = WKRandomPhotoViewModel.Configuration

	// MARK: - UI Elements

	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		return stackView
	}()

	private lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 20
		return stackView
	}()

	lazy var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView(style: .large)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		return activityIndicator
	}()

	private lazy var label: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit		
		return imageView
	}()

	private lazy var container: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private lazy var catsButton: WKButton = {
		let button = WKButton(configuration: .large(text: "Cats"))
		return button
	}()

	private lazy var dogsButton: WKButton = {
		let button = WKButton(configuration: .large(text: "Dogs"))
		return button
	}()

	// MARK: - Properties

	private var configuration: Configuration!

	public required init(configuration: Configuration) {
		self.configuration = configuration
		super.init(frame: .zero)
		setup()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public func update(configuration: Configuration) {
		self.configuration = configuration
		configure()
	}

	private func setup() {
		addSubview(container)
		container.addSubview(stackView)
		container.addSubview(activityIndicator)

		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(buttonStackView)

		buttonStackView.addArrangedSubview(catsButton)
		buttonStackView.addArrangedSubview(dogsButton)

		let margin: CGFloat = 25

		NSLayoutConstraint.activate([
			container.topAnchor.constraint(equalTo: topAnchor),
			container.bottomAnchor.constraint(equalTo: bottomAnchor),
			container.leadingAnchor.constraint(equalTo: leadingAnchor),
			container.trailingAnchor.constraint(equalTo: trailingAnchor),

			stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: margin),
			stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin),
			stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin),
			stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin),

			activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
		])

		configure()
	}

	private func configure() {
		backgroundColor = theme.background
		label.text = configuration.rawValue
		label.font = WKFont.for(.prominentTitle, compatibleWith: appEnvironment.traitCollection)
		label.textColor = theme.primaryText
		container.backgroundColor = theme.paperBackground
		activityIndicator.color = theme.primaryText
	}

	func update(configuration: Configuration, image: UIImage?) {
		self.configuration = configuration
		imageView.image = image
		configure()
	}

	override public func appEnvironmentDidChange() {
		configure()
	}

	// MARK: - Actions

	func addTarget(_ target: Any?, action: Selector, for controlEvent: UIControl.Event, configuration: Configuration) {
		switch configuration {
		case .dogs:
			dogsButton.addTarget(target, action: action, for: controlEvent)
		case .cats:
			catsButton.addTarget(target, action: action, for: controlEvent)
		}
	}


}

