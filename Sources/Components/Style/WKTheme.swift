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
    public let link: UIColor
    public let destructive: UIColor
    public let editorOrange: UIColor
    public let inputAccessoryButtonTint: UIColor
    public let inputAccessoryButtonSelectedTint: UIColor
    public let inputAccessoryButtonSelectedBackgroundColor: UIColor
    public let keyboardAppearance: UIKeyboardAppearance

	public static let light = WKTheme(
		name: "Light",
		background: WKColor.white,
		paperBackground: WKColor.lightGray,
		primaryText: WKColor.black,
		secondaryText: WKColor.gray,
		buttonBackground: WKColor.blue,
		secondaryButtonBackground: WKColor.teal,
		prominentText: WKColor.green,
		secondaryProminentText: WKColor.systemGreen,
        link: WKColor.blue,
        destructive: WKColor.red,
        editorOrange: WKColor.orange,
        inputAccessoryButtonTint: WKColor.black,
        inputAccessoryButtonSelectedTint: WKColor.black,
        inputAccessoryButtonSelectedBackgroundColor: WKColor.lightGray,
        keyboardAppearance: .light
	)
    
    public static let sepia = WKTheme(
        name: "Sepia",
        background: WKColor.white,
        paperBackground: WKColor.lightGray,
        primaryText: WKColor.black,
        secondaryText: WKColor.gray,
        buttonBackground: WKColor.blue,
        secondaryButtonBackground: WKColor.teal,
        prominentText: WKColor.green,
        secondaryProminentText: WKColor.systemGreen,
        link: WKColor.blue,
        destructive: WKColor.red,
        editorOrange: WKColor.blue,
        inputAccessoryButtonTint: WKColor.black,
        inputAccessoryButtonSelectedTint: WKColor.black,
        inputAccessoryButtonSelectedBackgroundColor: WKColor.lightGray,
        keyboardAppearance: .light
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
		secondaryProminentText: WKColor.cyan,
        link: WKColor.blue,
        destructive: WKColor.red,
        editorOrange: WKColor.green,
        inputAccessoryButtonTint: WKColor.white,
        inputAccessoryButtonSelectedTint: WKColor.white,
        inputAccessoryButtonSelectedBackgroundColor: WKColor.darkGray,
        keyboardAppearance: .dark
	)
    
    public static let black = WKTheme(
        name: "Black",
        background: WKColor.black,
        paperBackground: WKColor.darkGray,
        primaryText: WKColor.white,
        secondaryText: WKColor.gray,
        buttonBackground: WKColor.purple,
        secondaryButtonBackground: WKColor.orange,
        prominentText: WKColor.teal,
        secondaryProminentText: WKColor.cyan,
        link: WKColor.blue,
        destructive: WKColor.red,
        editorOrange: WKColor.red,
        inputAccessoryButtonTint: WKColor.white,
        inputAccessoryButtonSelectedTint: WKColor.white,
        inputAccessoryButtonSelectedBackgroundColor: WKColor.darkGray,
        keyboardAppearance: .dark
    )
}
