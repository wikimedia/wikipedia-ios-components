import UIKit

public struct WKTheme: Equatable {

	public let name: String
	public let background: UIColor
	public let paperBackground: UIColor
	public let primaryText: UIColor
	public let secondaryText: UIColor
	public let buttonBackground: UIColor
	public let secondaryButtonBackground: UIColor
	public let prominentText: UIColor
	public let secondaryProminentText: UIColor

	public static let light = WKTheme(
		name: "Light",
		background: WKColor.white,
		paperBackground: WKColor.lightGray,
		primaryText: WKColor.black,
		secondaryText: WKColor.gray,
		buttonBackground: WKColor.blue,
		secondaryButtonBackground: WKColor.teal,
		prominentText: WKColor.green,
		secondaryProminentText: WKColor.systemGreen
	)

	public static let dark = WKTheme(
		name: "Dark",
		background: WKColor.black,
		paperBackground: WKColor.darkGray,
		primaryText: WKColor.white,
		secondaryText: WKColor.gray,
		buttonBackground: WKColor.purple,
		secondaryButtonBackground: WKColor.orange,
		prominentText: WKColor.teal,
		secondaryProminentText: WKColor.cyan
	)
}
