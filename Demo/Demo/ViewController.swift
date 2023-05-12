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
            inputViewSubheading1: NSLocalizedString("source-editor-subheading1", value: "Sub-heading 1", comment: ""),
            inputViewSubheading2: NSLocalizedString("source-editor-subheading2", value: "Sub-heading 2", comment: ""),
            inputViewSubheading3: NSLocalizedString("source-editor-subheading3", value: "Sub-heading 3", comment: ""),
            inputViewSubheading4: NSLocalizedString("source-editor-subheading4", value: "Sub-heading 4", comment: ""),
            findReplaceTypeSingle: NSLocalizedString("source-editor-find-replace-single", value: "Replace", comment: ""),
            findReplaceTypeAll: NSLocalizedString("source-editor-find-replace-all", value: "Replace All", comment: ""),
            findReplaceWith: NSLocalizedString("source-editor-find-replace-with", value: "Replace with...", comment: ""),
            accessibilityLabelButtonFormatText: NSLocalizedString("source-editor-accessibility-label-format-text", value: "Show text formatting menu", comment: ""),
            accessibilityLabelButtonFormatHeading: NSLocalizedString("source-editor-accessibility-label-format-heading", value: "Show text style menu", comment: ""),
            accessibilityLabelButtonCitation: NSLocalizedString("source-editor-accessibility-label-citation", value: "Add reference syntax", comment: ""),
            accessibilityLabelButtonCitationSelected: NSLocalizedString("source-editor-accessibility-label-citation-selected", value: "Remove reference syntax", comment: ""),
            accessibilityLabelButtonLink: NSLocalizedString("source-editor-accessibility-label-link", value: "Add link syntax", comment: ""),
            accessibilityLabelButtonLinkSelected: NSLocalizedString("source-editor-accessibility-label-link-selected", value: "Remove link syntax", comment: ""),
            accessibilityLabelButtonTemplate: NSLocalizedString("source-editor-accessibility-label-template", value: "Add template syntax", comment: ""),
            accessibilityLabelButtonTemplateSelected: NSLocalizedString("source-editor-accessibility-label-template-selected", value: "Remove template syntax", comment: ""),
            accessibilityLabelButtonMedia: NSLocalizedString("source-editor-accessibility-label-media", value: "Insert media", comment: ""),
            accessibilityLabelButtonFind: NSLocalizedString("source-editor-accessibility-label-find", value: "Find in page", comment: ""),
            accessibilityLabelButtonListUnordered: NSLocalizedString("source-editor-accessibility-label-unordered", value: "Make current line unordered list", comment: ""),
            accessibilityLabelButtonListUnorderedSelected: NSLocalizedString("source-editor-accessibility-label-unordered-selected", value: "Remove unordered list from current line", comment: ""),
            accessibilityLabelButtonListOrdered: NSLocalizedString("source-editor-accessibility-label-ordered", value: "Make current line ordered list", comment: ""),
            accessibilityLabelButtonListOrderedSelected: NSLocalizedString("source-editor-accessibility-label-ordered-selected", value: "Remove ordered list from current line", comment: ""),
            accessibilityLabelButtonInceaseIndent: NSLocalizedString("source-editor-accessibility-label-indent-increase", value: "Increase indent depth", comment: ""),
            accessibilityLabelButtonDecreaseIndent: NSLocalizedString("source-editor-accessibility-label-indent-decrease", value: "Decrease indent depth", comment: ""),
            accessibilityLabelButtonCursorUp: NSLocalizedString("source-editor-accessibility-label-cursor-up", value: "Move cursor up", comment: ""),
            accessibilityLabelButtonCursorDown: NSLocalizedString("source-editor-accessibility-label-cursor-down", value: "Move cursor down", comment: ""),
            accessibilityLabelButtonCursorLeft: NSLocalizedString("source-editor-accessibility-label-cursor-left", value: "Move cursor left", comment: ""),
            accessibilityLabelButtonCursorRight: NSLocalizedString("source-editor-accessibility-label-cursor-right", value: "Move cursor right", comment: ""),
            accessibilityLabelButtonBold: NSLocalizedString("source-editor-accessibility-label-bold", value: "Add bold formatting", comment: ""),
            accessibilityLabelButtonBoldSelected: NSLocalizedString("source-editor-accessibility-label-bold-selected", value: "Remove bold formatting", comment: ""),
            accessibilityLabelButtonItalics: NSLocalizedString("source-editor-accessibility-label-italics", value: "Add italic formatting", comment: ""),
            accessibilityLabelButtonItalicsSelected: NSLocalizedString("source-editor-accessibility-label-italics-selected", value: "Remove italic formatting", comment: ""),
            accessibilityLabelButtonClearFormatting: NSLocalizedString("source-editor-accessibility-label-clear-formatting", value: "Clear formatting", comment: ""),
            accessibilityLabelButtonShowMore: NSLocalizedString("source-editor-accessibility-label-format-text", value: "Show text formatting menu", comment: ""), // common with format text buttons
            accessibilityLabelButtonComment: NSLocalizedString("source-editor-accessibility-label-comment", value: "Add comment syntax", comment: ""),
            accessibilityLabelButtonCommentSelected: NSLocalizedString("source-editor-accessibility-label-comment-selected", value: "Remove comment syntax", comment: ""),
            accessibilityLabelButtonSuperscript: NSLocalizedString("source-editor-accessibility-label-superscript", value: "Add superscript formatting", comment: ""),
            accessibilityLabelButtonSuperscriptSelected: NSLocalizedString("source-editor-accessibility-label-superscript-selected", value: "Remove superscript formatting", comment: ""),
            accessibilityLabelButtonSubscript: NSLocalizedString("source-editor-accessibility-label-subscript", value: "Add subscript formatting", comment: ""),
            accessibilityLabelButtonSubscriptSelected: NSLocalizedString("source-editor-accessibility-label-subscript-selected", value: "Remove subscript formatting", comment: ""),
            accessibilityLabelButtonUnderline: NSLocalizedString("source-editor-accessibility-label-underline", value: "Add underline", comment: ""),
            accessibilityLabelButtonUnderlineSelected: NSLocalizedString("source-editor-accessibility-label-underline-selected", value: "Remove underline", comment: ""),
            accessibilityLabelButtonStrikethrough: NSLocalizedString("source-editor-accessibility-label-strikethrough", value: "Add strikethrough", comment: ""),
            accessibilityLabelButtonStrikethroughSelected: NSLocalizedString("source-editor-accessibility-label-strikethrough-selected", value: "Remove strikethrough", comment: ""),
            accessibilityLabelButtonCloseMainInputView: NSLocalizedString("source-editor-accessibility-label-close-main-input", value: "Close text formatting menu", comment: ""),
            accessibilityLabelButtonCloseHeaderSelectInputView: NSLocalizedString("source-editor-accessibility-label-close-header-select", value: "Close text style menu", comment: ""),
            accessibilityLabelFindTextField: NSLocalizedString("source-editor-accessibility-label-find-text-field", value: "Find", comment: ""),
            accessibilityLabelFindButtonClear: NSLocalizedString("source-editor-accessibility-label-find-button-clear", value: "Clear find", comment: ""),
            accessibilityLabelFindButtonClose: NSLocalizedString("source-editor-accessibility-label-find-button-close", value: "Close find", comment: ""),
            accessibilityLabelFindButtonNext: NSLocalizedString("source-editor-accessibility-label-find-button-next", value: "Next find result", comment: ""),
            accessibilityLabelFindButtonPrevious: NSLocalizedString("source-editor-accessibility-label-find-button-prev", value: "Previous find result", comment: ""),
            accessibilityLabelReplaceTextField: NSLocalizedString("source-editor-accessibility-label-replace-text-field", value: "Replace", comment: ""),
            accessibilityLabelReplaceButtonClear: NSLocalizedString("source-editor-accessibility-label-replace-button-clear", value: "Clear replace", comment: ""),
            accessibilityLabelReplaceButtonPerformFormat: NSLocalizedString("source-editor-accessibility-label-replace-button-perform-format", value: "Perform replace operation. Replace type is set to %@", comment: ""),
            accessibilityLabelReplaceButtonSwitchFormat: NSLocalizedString("source-editor-accessibility-label-replace-button-switch-format", value: "Switch replace type. Currently set to %@. Select to change.", comment: ""),
            accessibilityLabelReplaceTypeSingle: NSLocalizedString("source-editor-accessibility-label-replace-type-single", value: "Replace single instance", comment: ""),
            accessibilityLabelReplaceTypeAll: NSLocalizedString("source-editor-accessibility-label-replace-type-all", value: "Replace all instances", comment: "")
            )
    }
}
