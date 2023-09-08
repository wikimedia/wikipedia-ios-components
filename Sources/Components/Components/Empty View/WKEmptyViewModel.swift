import UIKit

public class WKEmptyViewModel: ObservableObject {

    public struct LocalizedStrings {
        public var title: String
        public var subtitle: String
        public var titleFilter: String
        public var filterSubtitleModify: String
        public var filterSubtitleSeeMore: String
        public var buttonTitle: String
        public var numberOfFilters: ((Int) -> String)

        public init(title: String, subtitle: String, titleFilter: String, filterSubtitleModify: String, filterSubtitleSeeMore: String, buttonTitle: String, numberOfFilters: @escaping ((Int) -> String)) {
            self.title = title
            self.subtitle = subtitle
            self.titleFilter = titleFilter
            self.filterSubtitleModify = filterSubtitleModify
            self.filterSubtitleSeeMore = filterSubtitleSeeMore
            self.buttonTitle = buttonTitle
            self.numberOfFilters = numberOfFilters
        }
    }

    var localizedStrings: LocalizedStrings
    var image: UIImage
    var numberOfFilters: Int

    public init(localizedStrings: LocalizedStrings, image: UIImage, numberOfFilters: Int) {
        self.localizedStrings = localizedStrings
        self.image = image
        self.numberOfFilters = numberOfFilters
    }

    func filterString(localizedStrings: LocalizedStrings) -> String {
        return localizedStrings.numberOfFilters(numberOfFilters)
    }

}


public enum WKEmptyViewStateType {
    case noItems
    case filter
}

