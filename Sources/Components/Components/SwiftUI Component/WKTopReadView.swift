import SwiftUI

public struct WKTopReadView: View {

	// MARK: - Properties

	@ObservedObject var appEnvironment = WKAppEnvironment.current

	var theme: WKTheme {
		return appEnvironment.theme
	}

	var viewModel: WKTopReadViewModel

	// MARK: - Body

	public var body: some View {
		VStack(alignment: .leading) {
			ForEach(Array(viewModel.items.enumerated()), id: \.element) { index, item in
				WKTopReadRow(rank: index + 1, text: item)
			}
		}
		.padding(20)
		.background(Color(theme.paperBackground))
	}

}

struct WKTopReadRow: View {

	// MARK: - Properties

	@ObservedObject var appEnvironment = WKAppEnvironment.current

	var theme: WKTheme {
		return appEnvironment.theme
	}

	var rank: Int
	var text: String

	// MARK: - Body

	var body: some View {
		HStack(alignment: .center) {
			Text("\(rank)")
				.foregroundColor(Color(theme.prominentText))
				.font(Font.for(.smallHeadline))
			Spacer()
				.frame(width: 24)
			Text(text)
				.foregroundColor(Color(theme.secondaryProminentText))
				.font(Font.for(.prominentHeadline))
		}
	}

}
