import UIKit

public struct WKTheme: Equatable {

	public let name: String
    public let paperBackground: UIColor

	public static let light = WKTheme(
		name: "Light",
        paperBackground: WKColor.white
	)
    
    public static let sepia = WKTheme(
        name: "Sepia",
        paperBackground: WKColor.beige100
    )

	public static let dark = WKTheme(
		name: "Dark",
        paperBackground: WKColor.gray675
	)

	public static let black = WKTheme(
		name: "Black",
        paperBackground: WKColor.black
	)

}
