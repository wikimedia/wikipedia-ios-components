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
        let viewModel = WKSourceEditorViewModel(configuration: .full, initialText: "", accessibilityIdentifiers: .testIdentifiers, localizedStrings: .testStrings)
        let viewController = WKSourceEditorViewController(viewModel: viewModel, delegate: self)
        present(viewController, animated: true)
    }
}

extension ViewController: WKSourceEditorViewControllerDelegate {
    public func sourceEditorViewControllerDidTapFind(sourceEditorViewController: WKSourceEditorViewController) {
    }
}

private extension WKSourceEditorAccessibilityIdentifiers {
    static var testIdentifiers: WKSourceEditorAccessibilityIdentifiers {
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

public extension WKSourceEditorLocalizedStrings {
    static var testStrings: WKSourceEditorLocalizedStrings {
        
        // Note: We are only using NSLocalizedString here so that they are swapped out with pseudolanguages during UI Tests.
        // The main Wikipedia client app injects its own localized strings
        return WKSourceEditorLocalizedStrings(
            inputViewTextFormatting: NSLocalizedString("source-editor-text-formatting", value: "Text Formatting", comment: ""),
            inputViewStyle: NSLocalizedString("source-editor-style", value: "Style", comment: ""),
            inputViewClearFormatting: NSLocalizedString("source-editor-clear-formatting", value: "Clear Formatting", comment: ""),
            inputViewParagraph: NSLocalizedString("source-editor-paragraph", value: "Paragraph", comment: ""),
            inputViewHeading: NSLocalizedString("source-editor-heading", value: "Heading", comment: ""),
            inputViewSubheading1: NSLocalizedString("source-editor-clear-subheading1", value: "Sub-heading 1", comment: ""),
            inputViewSubheading2: NSLocalizedString("source-editor-clear-subheading2", value: "Sub-heading 2", comment: ""),
            inputViewSubheading3: NSLocalizedString("source-editor-clear-subheading3", value: "Sub-heading 3", comment: ""),
            inputViewSubheading4: NSLocalizedString("source-editor-clear-subheading4", value: "Sub-heading 4", comment: ""),
            findReplaceTypeSingle: NSLocalizedString("source-editor-find-replace-single", value: "Replace", comment: ""),
            findReplaceTypeAll: NSLocalizedString("source-editor-find-replace-all", value: "Replace All", comment: ""),
            findReplaceWith: NSLocalizedString("source-editor-find-replace-with", value: "Replace with...", comment: "")
            )
    }
}
