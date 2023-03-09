import SwiftUI

public protocol WKFeatureNavigationHostingControllerDelegate: AnyObject {
	func featureNavigationUserDidTap(_ feature: WKFeature)
}

public final class WKFeatureNavigationHostingController: WKComponentHostingController<WKFeatureNavigationView> {

	public init(delegate: WKFeatureNavigationHostingControllerDelegate?) {
		super.init(rootView: WKFeatureNavigationView(delegate: delegate))
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
