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
	weak var delegate: WKWatchlistDelegate?

	fileprivate lazy var filterBarButton = {
		let barButton = UIBarButtonItem(title: viewModel.localizedStrings.filter, style: .plain, target: nil, action: nil)
		return barButton
	}()

	// MARK: - Lifecycle

	public init(viewModel: WKWatchlistViewModel, delegate: WKWatchlistDelegate?) {
		self.viewModel = viewModel
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
		navigationItem.rightBarButtonItem = filterBarButton
	}

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.presentationConfiguration.showNavBarUponAppearance {
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if viewModel.presentationConfiguration.hideNavBarUponDisappearance {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
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
