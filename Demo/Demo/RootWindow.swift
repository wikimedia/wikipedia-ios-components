import UIKit
import Combine
import Components

/// The root window for the demo app. Trait collection changes are fed into the Components system here.
final class RootWindow: UIWindow {

	// MARK: - Private Properties

	private var cancellables = Set<AnyCancellable>()

	// MARK: - Lifecycle

    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)

		WKAppEnvironment.current.$theme.sink(receiveValue: { theme in
			self.overrideUserInterfaceStyle = theme.userInterfaceStyle
		}).store(in: &cancellables)

        WKAppEnvironment.updateWithTraitCollection(traitCollection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)

        WKAppEnvironment.updateWithTraitCollection(traitCollection)
	}

}
