import UIKit

public class WKEmptyViewModel: ObservableObject {

    public struct LocalizedStrings {
        public var title: String
        public var subtitle: String
        public var filterTitle: String
        public var buttonTitle: String
        public var filterSubtitle:  ((Int) -> String)
        public var numberOfFilters: ((Int) -> String)

        public init(title: String, subtitle: String, filterTitle: String, buttonTitle: String, filterSubtitle: @escaping (Int) -> String, numberOfFilters: @escaping (Int) -> String) {
            self.title = title
            self.subtitle = subtitle
            self.filterTitle = filterTitle
            self.buttonTitle = buttonTitle
            self.filterSubtitle = filterSubtitle
            self.numberOfFilters = numberOfFilters
        }
    }

    var localizedStrings: LocalizedStrings
    var image: UIImage
    @Published var numberOfFilters: Int

    public init(localizedStrings: LocalizedStrings, image: UIImage, numberOfFilters: Int) {
        self.localizedStrings = localizedStrings
        self.image = image
        self.numberOfFilters = numberOfFilters
    }
    
    func filterString(localizedStrings: LocalizedStrings) -> String {
        return localizedStrings.numberOfFilters(numberOfFilters)
    }

    func filterSubtitleString(localizedStrings: LocalizedStrings) -> String {
        return localizedStrings.filterSubtitle(numberOfFilters)
    }
}


public enum WKEmptyViewStateType {
    case noItems
    case filter
}

