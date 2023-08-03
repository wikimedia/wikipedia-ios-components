import SwiftUI

public class WKOnboardingViewController: WKCanvasViewController {
    
   // MARK: - Properties

    private let hostingController: WKOnboardingHostingViewController

    public override init() {
        self.hostingController = WKOnboardingHostingViewController()
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    public override func viewDidLoad() {
            super.viewDidLoad()
            addComponent(hostingController, pinToEdges: true)

            self.title = "Onboarding"

        }
}

fileprivate final class WKOnboardingHostingViewController: WKComponentHostingController<WKOnboardingView> {

    init() {
        super.init(rootView: WKOnboardingView())
    }

    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
