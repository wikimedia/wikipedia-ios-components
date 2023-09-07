import SwiftUI

final class WKEmptyViewController: WKCanvasViewController {

    var hostingController: WKEmptyViewHostingController

    public init(viewModel: WKEmptyViewModel) {
        self.hostingController = WKEmptyViewHostingController(viewModel: viewModel)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
            addComponent(hostingController, pinToEdges: true)
    }

}

final class WKEmptyViewHostingController: WKComponentHostingController<WKEmptyView> {

    init(viewModel: WKEmptyViewModel) {
        super.init(rootView: WKEmptyView(viewModel: viewModel, type: .noItems))

    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
