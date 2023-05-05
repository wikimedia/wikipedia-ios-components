import UIKit

public struct WKTheme: Equatable {

	public let name: String
    public let text: UIColor
    public let secondaryText: UIColor
    public let link: UIColor
    public let destructive: UIColor
    public let border: UIColor
    public let paperBackground: UIColor
    public let accessoryBackground: UIColor
    public let inputAccessoryButtonTint: UIColor
    public let inputAccessoryButtonSelectedTint: UIColor
    public let inputAccessoryButtonSelectedBackgroundColor: UIColor
    public let keyboardBarSearchFieldBackground: UIColor
    public let keyboardAppearance: UIKeyboardAppearance

	public static let light = WKTheme(
        name: "Light",
        text: WKColor.gray700,
        secondaryText: WKColor.gray500,
        link: WKColor.blue600,
        destructive: WKColor.red600,
        border: WKColor.gray400,
        paperBackground: WKColor.white,
        accessoryBackground: WKColor.white,
        inputAccessoryButtonTint: WKColor.gray600,
        inputAccessoryButtonSelectedTint: WKColor.gray700,
        inputAccessoryButtonSelectedBackgroundColor: WKColor.gray200,
        keyboardBarSearchFieldBackground: WKColor.gray200,
        keyboardAppearance: .light
	)
    
    public static let sepia = WKTheme(
        name: "Sepia",
        text: WKColor.gray700,
        secondaryText: WKColor.taupe600,
        link: .blue600,
        destructive: .red700,
        border: .taupe200,
        paperBackground: WKColor.beige100,
        accessoryBackground: WKColor.beige300,
        inputAccessoryButtonTint: WKColor.gray600,
        inputAccessoryButtonSelectedTint: WKColor.gray700,
        inputAccessoryButtonSelectedBackgroundColor: WKColor.beige400,
        keyboardBarSearchFieldBackground: WKColor.gray200,
        keyboardAppearance: .light
    )

	public static let dark = WKTheme(
		name: "Dark",
        text: WKColor.gray100,
        secondaryText: WKColor.gray300,
        link: .blue300,
        destructive: .red600,
        border: .gray650,
        paperBackground: WKColor.gray675,
        accessoryBackground: WKColor.gray700,
        inputAccessoryButtonTint: WKColor.gray100,
        inputAccessoryButtonSelectedTint: WKColor.gray100,
        inputAccessoryButtonSelectedBackgroundColor: WKColor.gray800,
        keyboardBarSearchFieldBackground: WKColor.gray650,
        keyboardAppearance: .dark
	)

	public static let black = WKTheme(
		name: "Black",
        text: WKColor.gray100,
        secondaryText: WKColor.gray300,
        link: .blue300,
        destructive: .red600,
        border: .gray675,
        paperBackground: WKColor.black,
        accessoryBackground: WKColor.gray700,
        inputAccessoryButtonTint: WKColor.gray100,
        inputAccessoryButtonSelectedTint: WKColor.gray100,
        inputAccessoryButtonSelectedBackgroundColor: WKColor.gray800,
        keyboardBarSearchFieldBackground: WKColor.gray650,
        keyboardAppearance: .dark
	)

}
