import SwiftUI

public class WKOnboardingViewController: WKCanvasViewController {
    
   // MARK: - Properties

    private let hostingController: WKOnboardingHostingViewController

    public init(viewModel: WKOnboardingViewModel) {
        self.hostingController = WKOnboardingHostingViewController(viewModel: viewModel)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    public override func viewDidLoad() {
            super.viewDidLoad()
            addComponent(hostingController, pinToEdges: true)

        }
}

fileprivate final class WKOnboardingHostingViewController: WKComponentHostingController<WKOnboardingView> {

    init(viewModel: WKOnboardingViewModel) {
        super.init(rootView: WKOnboardingView(viewModel: viewModel))
    }

    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
