
import Foundation

extension Notification.Name {
    static let WMFUserDidSelectThemeNotification = Notification.Name("WMFUserDidSelectThemeNotification")
}

extension NSNotification {
    struct UserInfoKeys {
        static let WMFUserDidSelectThemeNotificationThemeNameKey = "themeName"
    }
}
