import SwiftUI

public struct WKFeatureNavigationView: View {

	// MARK: - Properties

	@ObservedObject var appEnvironment = WKAppEnvironment.current

	var theme: WKTheme {
		return appEnvironment.theme
	}

	public weak var delegate: WKFeatureNavigationHostingControllerDelegate?

	// MARK: - Body

	public var body: some View {
		List(WKFeature.allCases) { feature in
			HStack {
				Button(action: {
					delegate?.featureNavigationUserDidTap(feature)
				}, label: {
					Text(feature.rawValue)
						.font(Font.for(.body))
				})
				Spacer()
				Text(feature.framework)
					.font(Font.for(.caption))
					.foregroundColor(Color(theme.secondaryText))
			}
			.listRowBackground(Color(theme.paperBackground))
		}
		.listBackgroundColor(Color(theme.background))
	}

}
