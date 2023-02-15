import Foundation
import UIComponents
import UIKit

extension UserDefaults {
    
    private struct Keys {
        static let themeName = "WMFAppThemeName"
    }
    
    var themeName: String
    {
        get {
            string(forKey: Keys.themeName) ?? Theme.defaultThemeName
        }
        set {
            set(newValue, forKey: Keys.themeName)
        }
    }
    
    func theme(compatibleWith traitCollection: UITraitCollection?) -> Theme {
        let name = string(forKey: Keys.themeName)
        let systemDarkMode = traitCollection?.userInterfaceStyle == .dark

        guard name != nil, name != Theme.defaultThemeName else {
            return systemDarkMode ? Theme.black : .light
        }
        
        let theme = Theme.withName(name) ?? Theme.light
        return theme
    }
}
