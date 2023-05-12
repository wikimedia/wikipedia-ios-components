import UIKit
import Components

class ViewController: WKCanvasViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var selectThemeButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Select Theme", for: .normal)
        button.addTarget(self, action: #selector(tappedSelectTheme), for: .touchUpInside)
        return button
    }()
    
    private lazy var sourceEditorButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Source Editor", for: .normal)
        button.accessibilityIdentifier = DemoSourceEditorAccessibilityIdentifiers.entryButton.rawValue
        button.addTarget(self, action: #selector(tappedSourceEditor), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupInitialViews()
        
        stackView.addArrangedSubview(selectThemeButton)
        stackView.addArrangedSubview(sourceEditorButton)
    }
    
    private func setupInitialViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    @objc private func tappedSelectTheme() {
        let viewController = SelectThemeViewController()
        present(viewController, animated: true)
    }
    
    @objc private func tappedSourceEditor() {
        let viewModel = WKSourceEditorViewModel(configuration: .full, initialText: "", accessibilityIdentifiers: .demo)
        let viewController = WKSourceEditorViewController(viewModel: viewModel, delegate: self)
        present(viewController, animated: true)
    }
}

extension ViewController: WKSourceEditorViewControllerDelegate {
    public func sourceEditorViewControllerDidTapFind(sourceEditorViewController: WKSourceEditorViewController) {
    }
}

private extension WKSourceEditorAccessibilityIdentifiers {
    static var demo: WKSourceEditorAccessibilityIdentifiers {
        return WKSourceEditorAccessibilityIdentifiers(
            textView: DemoSourceEditorAccessibilityIdentifiers.textView.rawValue,
            expandButton: DemoSourceEditorAccessibilityIdentifiers.expandButton.rawValue,
            findButton: DemoSourceEditorAccessibilityIdentifiers.findButton.rawValue,
            showMoreButton: DemoSourceEditorAccessibilityIdentifiers.showMoreButton.rawValue,
            closeButton: DemoSourceEditorAccessibilityIdentifiers.closeButton.rawValue,
            formatTextButton: DemoSourceEditorAccessibilityIdentifiers.formatTextButton.rawValue,
            formatHeadingButton: DemoSourceEditorAccessibilityIdentifiers.formatHeadingButton.rawValue,
            expandingToolbar: DemoSourceEditorAccessibilityIdentifiers.expandingToolbar.rawValue,
            highlightToolbar: DemoSourceEditorAccessibilityIdentifiers.highlightToolbar.rawValue,
            findToolbar: DemoSourceEditorAccessibilityIdentifiers.findButton.rawValue,
            mainInputView: DemoSourceEditorAccessibilityIdentifiers.mainInputView.rawValue,
            headerSelectInputView: DemoSourceEditorAccessibilityIdentifiers.headerSelectInputView.rawValue
        )
    }
}
