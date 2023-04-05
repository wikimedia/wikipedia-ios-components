import Foundation

public class WKSourceEditorViewController: WKComponentViewController {
    
    // MARK: - Properties
    
    let viewModel: WKSourceEditorViewModel
    
    var customView: WKSourceEditorView {
        return view as! WKSourceEditorView
    }
    
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
    }
}
