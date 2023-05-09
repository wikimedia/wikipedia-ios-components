import Foundation

let WKThemeNameKey = "WKThemeNameKey"

extension UserDefaults {
    @objc var themeName: String? {
        get {
            return string(forKey: WKThemeNameKey)
        }
        set {
            set(newValue, forKey: WKThemeNameKey)
        }
    }

}
