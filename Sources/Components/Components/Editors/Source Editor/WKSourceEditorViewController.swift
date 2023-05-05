import Foundation
import UIKit

public class WKSourceEditorViewController: WKComponentViewController {
    
    // MARK: - Properties
    
    private let viewModel: WKSourceEditorViewModel
    
    private var editorView: WKSourceEditorView {
        return view as! WKSourceEditorView
    }
    
    // MARK: - Lifecycle
    
    public init(viewModel: WKSourceEditorViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = WKSourceEditorView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        editorView.setInitialText(viewModel.initialText)
    }
}
