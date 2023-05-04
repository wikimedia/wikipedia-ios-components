import UIKit
import Components

/// The root window for the demo app. Trait collection changes are fed into the Components system here.
final class RootWindow: UIWindow {
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        
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
