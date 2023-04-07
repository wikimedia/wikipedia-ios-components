import Foundation
import UIKit

class WKEditToolbarView: WKComponentView {
    
    @IBOutlet var separatorViews: [UIView] = []
    @IBOutlet var buttons: [WKEditToolbarButton] = []

    override var intrinsicContentSize: CGSize {
        let height = buttons.map { $0.intrinsicContentSize.height }.max() ?? UIView.noIntrinsicMetric
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
}
