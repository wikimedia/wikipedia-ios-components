import UIKit

public struct WKTheme: Equatable {

	public let name: String
	public let background: UIColor

	public static let light = WKTheme(
		name: "Light",
		background: WKColor.white
	)

	public static let dark = WKTheme(
		name: "Dark",
		background: WKColor.black
	)

	public static let black = WKTheme(
		name: "Black",
		background: WKColor.black
	)

	public static let sepia = WKTheme(
		name: "Sepia",
		background: WKColor.white
	)

}
