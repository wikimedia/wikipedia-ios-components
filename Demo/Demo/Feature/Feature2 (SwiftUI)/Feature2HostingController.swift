import Foundation
import UIKit
import SwiftUI
import UIComponents

class Feature2ViewController: UIViewController, Themeable {
    
    private var observableTheme: ObservableTheme
    
    init(theme: Theme) {
        self.observableTheme = ObservableTheme(theme: theme)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let childHostingVC: UIViewController
        
        let rootView = Feature2View()
            .environmentObject(observableTheme)

        if #available(iOS 16, *) {
            childHostingVC = UIHostingController(rootView: rootView)
        } else {
            childHostingVC = NavigationBarHidingHostingViewController(rootView: rootView)
        }
        
        childHostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childHostingVC.view)

        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: childHostingVC.view.topAnchor),
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: childHostingVC.view.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: childHostingVC.view.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: childHostingVC.view.bottomAnchor)
        ])
        
        addChild(childHostingVC)
        childHostingVC.didMove(toParent: self)
        childHostingVC.view.backgroundColor = .clear
        
        apply(theme: observableTheme.theme)
    }
    
    func apply(theme: Theme) {
        observableTheme.theme = theme
        view.backgroundColor = theme.colors.baseBackground
    }
}
