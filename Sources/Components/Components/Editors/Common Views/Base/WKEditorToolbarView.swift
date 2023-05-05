import Foundation
import UIKit

class WKEditorToolbarView: WKComponentView {
    
    // MARK: - Properties
    
    @IBOutlet var separatorViews: [UIView] = []
    @IBOutlet var buttons: [WKEditorToolbarButton] = []
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override var intrinsicContentSize: CGSize {
        let height = buttons.map { $0.intrinsicContentSize.height }.max() ?? UIView.noIntrinsicMetric
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
}
