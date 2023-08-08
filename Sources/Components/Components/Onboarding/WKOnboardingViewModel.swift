import UIKit

public struct WKOnboardingViewModel {

    // MARK: - Properties

    var title: String
    var cells: [WKOnboardingCellViewModel]
    var mainButtonTitle: String
    var secondaryButtonTitle: String?

    // MARK: - Lifecycle

    public init(title: String, cells: [WKOnboardingCellViewModel], mainButtonTitle: String, secondaryButtonTitle: String?) {
        self.title = title
        self.cells = cells
        self.mainButtonTitle = mainButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
    }

    public struct WKOnboardingCellViewModel {
        var icon: UIImage?
        var title: String
        var subtitle: String?

        public init(icon: UIImage?, title: String, subtitle: String?) {
            self.icon = icon
            self.title = title
            self.subtitle = subtitle
        }
    }
}
