import Foundation
import UIKit

fileprivate extension UIColor {
    convenience init(_ hex: Int, alpha: CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    static let gray100 = UIColor(0xF8F9FA)
    static let gray200 = UIColor(0xEAECF0)
    static let gray300 = UIColor(0xC8CCD1)
    static let gray400 = UIColor(0xA2A9B1)
    static let gray500 = UIColor(0x72777D)
    static let gray675 = UIColor(0x27292D)
    static let gray700 = UIColor(0x202122)
    static let gray800 = UIColor(0x101418)
    static let beige100 = UIColor(0xF8F1E3)
    static let beige400 = UIColor(0xE1DAD1)
    static let taupe600 = UIColor(0x646059)
    static let blue300 = UIColor(0x6699FF)
    static let blue600 = UIColor(0x3366CC)
}

public class Colors {
    
    public static let light = Colors(paperBackground: .white, baseBackground: .gray200, chromeBackground: .white, text: .gray700, secondaryText: .gray500, link: .blue600, unselected: .gray400)
    public static let sepia = Colors(paperBackground: .beige100, baseBackground: .beige400, chromeBackground: .beige100, text: .gray700, secondaryText: .taupe600, link: .blue600, unselected: .taupe600)
    public static let dark = Colors(paperBackground: .gray675, baseBackground: .gray800, chromeBackground: .gray700, text: .gray100, secondaryText: .gray300, link: .blue300, unselected: .gray300)
    public static let black = Colors(paperBackground: .black, baseBackground: .gray800, chromeBackground: .gray700, text: .gray100, secondaryText: .gray300, link: .blue300, unselected: .gray300)
    
    public let paperBackground: UIColor
    public let baseBackground: UIColor
    public let chromeBackground: UIColor
    public let text: UIColor
    public let secondaryText: UIColor
    public let link: UIColor
    public let unselected: UIColor
    
    init(paperBackground: UIColor, baseBackground: UIColor, chromeBackground: UIColor, text: UIColor, secondaryText: UIColor, link: UIColor, unselected: UIColor) {
        self.paperBackground = paperBackground
        self.baseBackground = baseBackground
        self.chromeBackground = chromeBackground
        self.text = text
        self.secondaryText = secondaryText
        self.link = link
        self.unselected = unselected
    }
}

public class Theme {
    
    public static let standard = Theme.light
    public static let light = Theme(colors: .light, name: "light", displayName: "Light")
    public static let sepia = Theme(colors: .sepia, name: "sepia", displayName: "Sepia")
    public static let dark = Theme(colors: .dark, name: "dark", displayName: "Dark")
    public static let black = Theme(colors: .black, name: "black", displayName: "Black")
    
    private static let themesByName = [Theme.light.name: Theme.light, Theme.dark.name: Theme.dark, Theme.sepia.name: Theme.sepia, Theme.black.name: Theme.black]
    
    public static let defaultThemeName = "standard"
    private static let darkThemePrefix = "dark"
    private static let blackThemePrefix = "black"

    public let colors: Colors
    public let name: String
    public let displayName: String
    
    init(colors: Colors, name: String, displayName: String) {
        self.colors = colors
        self.name = name
        self.displayName = displayName
    }
    
    public lazy var tabBarTitleTextAttributes: [NSAttributedString.Key: Any] = {
        return [.foregroundColor: colors.secondaryText]
    }()
    
    public lazy var tabBarSelectedTitleTextAttributes: [NSAttributedString.Key: Any] = {
        return [.foregroundColor: colors.link]
    }()
    
    public static func withName(_ name: String?) -> Theme? {
        guard let name = name else {
            return nil
        }
        return themesByName[name]
    }
    
    public static func isDefaultThemeName(_ name: String) -> Bool {
        return name == defaultThemeName
    }
    
    public static func isDarkThemeName(_ name: String) -> Bool {
        return name.hasPrefix(darkThemePrefix) || name.hasPrefix(blackThemePrefix)
    }
}

extension Theme: Equatable {
    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.name == rhs.name
    }
}
