import UIKit
import SwiftUI

public protocol WKWatchlistDelegate: AnyObject {
	func watchlistDidDismiss()
	func watchlistDidTapDiff()
}

public final class WKWatchlistViewController: WKCanvasViewController {

	// MARK: - Properties

	fileprivate let hostingViewController: WKWatchlistHostingViewController
	let viewModel: WKWatchlistViewModel
    let filterViewModel: WKWatchlistFilterViewModel
	weak var delegate: WKWatchlistDelegate?

	fileprivate lazy var filterBarButton = {
        let action = UIAction { [weak self] _ in
            guard let self else {
                return
            }
            
            self.present(WKWatchlistFilterHostingController(viewModel: self.filterViewModel), animated: true)
        }
        let barButton = UIBarButtonItem(title: viewModel.localizedStrings.filter, primaryAction: action)
		return barButton
	}()

	// MARK: - Lifecycle

    public init(viewModel: WKWatchlistViewModel, filterViewModel: WKWatchlistFilterViewModel, delegate: WKWatchlistDelegate?) {
		self.viewModel = viewModel
        self.filterViewModel = filterViewModel
		self.delegate = delegate
		self.hostingViewController = WKWatchlistHostingViewController(viewModel: viewModel, delegate: delegate)
		super.init()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		addComponent(hostingViewController, pinToEdges: true)

		self.title = viewModel.localizedStrings.title
		self.navigationController?.setNavigationBarHidden(false, animated: true)
		navigationItem.rightBarButtonItem = filterBarButton
	}

}

fileprivate final class WKWatchlistHostingViewController: WKComponentHostingController<WKWatchlistView> {

	let viewModel: WKWatchlistViewModel

	init(viewModel: WKWatchlistViewModel, delegate: WKWatchlistDelegate?) {
		self.viewModel = viewModel
		super.init(rootView: WKWatchlistView(viewModel: viewModel, delegate: delegate))
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
