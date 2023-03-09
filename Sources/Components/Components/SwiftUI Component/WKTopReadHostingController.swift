import SwiftUI

public class WKTopReadHostingController: WKComponentHostingController<WKTopReadView> {

	public init(viewModel: WKTopReadViewModel) {
		let view = WKTopReadView(viewModel: viewModel)
		super.init(rootView: view)
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

}
