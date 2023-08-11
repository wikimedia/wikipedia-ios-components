import Foundation
import UIKit

final class WKFormItemSelectViewModel: ObservableObject, Identifiable, Equatable {

    static func == (lhs: WKFormItemSelectViewModel, rhs: WKFormItemSelectViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    let id = UUID()
    let image: UIImage?
    let title: String?
    @Published var isSelected: Bool

    init(image: UIImage? = nil, title: String?, isSelected: Bool) {
        self.image = image
        self.title = title
        self.isSelected = isSelected
    }
}
