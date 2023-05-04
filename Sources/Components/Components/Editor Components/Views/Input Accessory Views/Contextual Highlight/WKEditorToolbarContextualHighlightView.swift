import UIKit

protocol WKEditorToolbarContextualHighlightViewDelegate: AnyObject {
    func toolbarContextualHighlightViewDidTapShowMore(toolbarExpandingView: WKEditorToolbarContextualHighlightView)
    func toolbarContextualHighlightViewDidTapFormatHeading(toolbarExpandingView: WKEditorToolbarContextualHighlightView)
    func toolbarContextualHighlightViewDidTapBold(toolbarExpandingView: WKEditorToolbarContextualHighlightView)
    func toolbarContextualHighlightViewDidTapItalics(toolbarExpandingView: WKEditorToolbarContextualHighlightView)
}

class WKEditorToolbarContextualHighlightView: WKEditorToolbarView {
    @IBOutlet private weak var stackView: UIStackView!
    
    @IBOutlet weak var boldButton: WKEditorToolbarButton!
    @IBOutlet weak var italicsButton: WKEditorToolbarButton!
    @IBOutlet weak var formatHeadingButton: WKEditorToolbarButton!
    @IBOutlet weak var citationButton: WKEditorToolbarButton!
    @IBOutlet weak var linkButton: WKEditorToolbarButton!
    @IBOutlet weak var templateButton: WKEditorToolbarButton!
    @IBOutlet weak var clearMarkupButton: WKEditorToolbarButton!
    @IBOutlet weak var showMoreButton: WKEditorToolbarNavigatorButton!
    
    weak var delegate: WKEditorToolbarContextualHighlightViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        boldButton.setImage(WKIcon.bold, for: .normal)
        boldButton.addTarget(self, action: #selector(tappedBold), for: .touchUpInside)
        
        italicsButton.setImage(WKIcon.italics, for: .normal)
        italicsButton.addTarget(self, action: #selector(tappedItalics), for: .touchUpInside)
        
        formatHeadingButton.setImage(WKIcon.formatHeading, for: .normal)
        formatHeadingButton.addTarget(self, action: #selector(tappedFormatHeading), for: .touchUpInside)
        
        citationButton.setImage(WKIcon.citation, for: .normal)
        citationButton.addTarget(self, action: #selector(tappedCitation), for: .touchUpInside)
        
        linkButton.setImage(WKIcon.link, for: .normal)
        linkButton.addTarget(self, action: #selector(tappedLink), for: .touchUpInside)
        
        templateButton.setImage(WKIcon.template, for: .normal)
        templateButton.addTarget(self, action: #selector(tappedTemplate), for: .touchUpInside)
        
        clearMarkupButton.setImage(WKIcon.clearMarkup, for: .normal)
        clearMarkupButton.addTarget(self, action: #selector(tappedClearMarkup), for: .touchUpInside)
        
        showMoreButton.setImage(WKIcon.plusCircleFill, for: .normal)
        showMoreButton.addTarget(self, action: #selector(tappedShowMore), for: .touchUpInside)
        
        updateColors()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonSelectionStates(_:)), name: Notification.sourceEditorUpdateButtonSelectionStates, object: nil)
    }
    
    override func appEnvironmentDidChange() {
        super.appEnvironmentDidChange()
        updateColors()
    }
    
    func updateSelectionStates(_ selectionStates: WKSourceEditorInputButtonSelectedStates) {
        boldButton.isSelected = selectionStates.isBoldSelected
        italicsButton.isSelected = selectionStates.isItalicsSelected
    }
    
    private func updateColors() {
        backgroundColor = WKAppEnvironment.current.theme.background
    }
    
// MARK: Button Actions

    @objc private func tappedBold() {
        delegate?.toolbarContextualHighlightViewDidTapBold(toolbarExpandingView: self)
    }

    @objc private func tappedItalics() {
        delegate?.toolbarContextualHighlightViewDidTapItalics(toolbarExpandingView: self)
    }

    @objc private func tappedFormatHeading() {
        delegate?.toolbarContextualHighlightViewDidTapFormatHeading(toolbarExpandingView: self)
    }

    @objc private func tappedCitation() {
        //delegate?.textFormattingProvidingDidTapReference()
    }

    @objc private func tappedLink() {
        //delegate?.textFormattingProvidingDidTapLink()
    }

    @objc private func tappedTemplate() {
        //delegate?.textFormattingProvidingDidTapTemplate()
    }

    @objc private func tappedClearMarkup() {
        //delegate?.textFormattingProvidingDidTapClearFormatting()
    }

    @objc private func tappedShowMore() {
        delegate?.toolbarContextualHighlightViewDidTapShowMore(toolbarExpandingView: self)
    }
    
// MARK: Notifications
    
    @objc private func updateButtonSelectionStates(_ note: Notification) {
        guard let selectionStates = note.userInfo?[String.WKSourceEditorButtonSelectionStatesKey] as? WKSourceEditorInputButtonSelectedStates else {
            return
        }
        boldButton.isSelected = selectionStates.isBoldSelected
        italicsButton.isSelected = selectionStates.isItalicsSelected
    }
}
