import UIKit

struct WKEmptyViewModel {

    enum EmptyStateType: Equatable {
        case noItems
        case filter
    }

    var image: UIImage
    var title: String
    var subtitle: String
    var buttonTitle: String?
    var type: EmptyStateType
    var activeFilters: Int?

    init(image: UIImage, title: String, subtitle: String, buttonTitle: String?, type: EmptyStateType, activeFilters: Int? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.type = type
        self.activeFilters = activeFilters
    }

}

