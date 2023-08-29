import UIKit

struct WKEmptyViewModel {

    enum EmptyStateType: Equatable {
        case noItems
        case filter
    }

    struct EmptyStateFilterSubtitleModel {
        var modifyString: String
        var filterString: String
        var viewMoreString: String
    }

    var image: UIImage
    var title: String
    var subtitle: String
    var filterSubtitle: EmptyStateFilterSubtitleModel
    var buttonTitle: String?
    var type: EmptyStateType
    var activeFilters: Int?

    init(image: UIImage, title: String, subtitle: String, filterSubtitle: EmptyStateFilterSubtitleModel, buttonTitle: String?, type: EmptyStateType, activeFilters: Int? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.filterSubtitle = filterSubtitle
        self.buttonTitle = buttonTitle
        self.type = type
        self.activeFilters = activeFilters
    }

}

