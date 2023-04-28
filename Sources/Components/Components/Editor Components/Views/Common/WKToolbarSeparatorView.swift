import Foundation

class WKToolbarSeparatorView: WKComponentView {
    var separatorSize = CGSize(width: 1, height: 32) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return separatorSize
    }
}
