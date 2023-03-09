import SwiftUI

public struct WKUICommunicationSwiftUIView: View {

	// MARK: - Properties

	@ObservedObject var data: WKCommunicationData
	
	@ObservedObject var appEnvironment = WKAppEnvironment.current

	var theme: WKTheme {
		return appEnvironment.theme
	}

	// MARK: - Body

	public var body: some View {
		VStack {
			Text("👇 I'm a SwiftUI view")
				.foregroundColor(Color(theme.primaryText))
				.font(.for(.headline))
				.frame(maxWidth: .infinity, minHeight: 60)
				.background(Color(theme.prominentText))
			Spacer()
			Text(data.text)
				.font(.for(.body))
			Spacer()
				.frame(height: 10)
			Text(data.date, style: .date)
				.font(.for(.smallHeadline))
			Text(data.date, style: .time)
				.font(.for(.smallHeadline))
			Text(data.date, style: .timer)
				.font(.for(.smallHeadline))
			Spacer()
		}
	}
	
}
