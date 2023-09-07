import UIKit

public class WKEmptyViewModel: ObservableObject {

    public enum EmptyStateType {
        case noItems
        case filter
    }

    public struct LocalizedStrings {
        public var title: String
        public var subtitle: String
        public var filterSubtitle: String
        public var buttonTitle: String

        public init(title: String, subtitle: String, filterSubtitle: String, buttonTitle: String) {
            self.title = title
            self.subtitle = subtitle
            self.filterSubtitle = filterSubtitle
            self.buttonTitle = buttonTitle
        }
    }

    var localizedStrings: LocalizedStrings
    var image: UIImage
    var type: EmptyStateType

    public init(localizedStrings: LocalizedStrings, image: UIImage, type: EmptyStateType) {
        self.localizedStrings = localizedStrings
        self.image = image
        self.type = type
    }

}

