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
        
        let rootView = Feature2View()
            .environmentObject(observableTheme)
        let hostingVC = UIHostingController(rootView: rootView)
        
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingVC.view)

        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: hostingVC.view.topAnchor),
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: hostingVC.view.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: hostingVC.view.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: hostingVC.view.bottomAnchor)
        ])
        
        addChild(hostingVC)
        hostingVC.didMove(toParent: self)
        hostingVC.view.backgroundColor = .clear
        
        apply(theme: observableTheme.theme)
    }
    
    func apply(theme: Theme) {
        observableTheme.theme = theme
        view.backgroundColor = theme.colors.baseBackground
    }
}
