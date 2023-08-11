import Foundation
import SwiftUI

class WKWatchlistFilterHostingController: WKComponentHostingController<WKWatchlistFilterView> {
    
    private let viewModel: WKWatchlistFilterViewModel
    
    public init(viewModel: WKWatchlistFilterViewModel) {
        self.viewModel = viewModel
        super.init(rootView: WKWatchlistFilterView(viewModel: viewModel))
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
