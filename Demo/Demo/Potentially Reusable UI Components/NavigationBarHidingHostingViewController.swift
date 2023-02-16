import Foundation
import SwiftUI

// Note: This subclass only seems necessary for proper nav bar hiding in iOS 14 & 15. It can be removed and switched to raw UIHostingControllers for iOS16+
class NavigationBarHidingHostingViewController<Content: View>: UIHostingController<Content> {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }
}
