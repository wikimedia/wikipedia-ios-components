import Foundation
import UIKit

public class WKSourceEditorViewController: WKComponentViewController {
    
    // MARK: - Properties
    
    let viewModel: WKSourceEditorViewModel
    
    var customView: WKSourceEditorView {
        return view as! WKSourceEditorView
    }
    
    lazy var floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap me!", for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    public init(viewModel: WKSourceEditorViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = WKSourceEditorView(configuration: viewModel.configuration)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.textView.attributedText = NSAttributedString(string: viewModel.wikitext)
        view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: floatingButton.trailingAnchor),
            view.topAnchor.constraint(equalTo: floatingButton.topAnchor)
            ])
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        customView.inputAccessoryViewType = .standard
    }
    
    @objc func tapped() {
//        let random = Int.random(in: 1...5)
//        switch random {
//        case 1:
//            customView.inputAccessoryViewType = .standard
//        case 2:
//            customView.inputAccessoryViewType = .highlight
//        case 3:
//            customView.inputAccessoryViewType = .findInPage
//        case 4:
            customView.inputViewType = .main
//        case 5:
//            customView.inputViewType = .headerSelect
//        default:
//            print("blah")
//        }
    }
}
