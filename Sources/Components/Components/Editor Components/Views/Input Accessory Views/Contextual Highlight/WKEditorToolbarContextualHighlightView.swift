import UIKit

protocol WKEditorToolbarContextualHighlightViewDelegate: AnyObject {
    func toolbarContextualHighlightViewDidTapShowMore(toolbarExpandingView: WKEditorToolbarContextualHighlightView)
    func toolbarContextualHighlightViewDidTapFormatHeading(toolbarExpandingView: WKEditorToolbarContextualHighlightView)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectBold), name: Notification.sourceEditorSelectBold, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deselectBold), name: Notification.sourceEditorDeselectBold, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectItalics), name: Notification.sourceEditorSelectItalics, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deselectItalics), name: Notification.sourceEditorDeselectItalics, object: nil)
    }
    
    override func appEnvironmentDidChange() {
        super.appEnvironmentDidChange()
        updateColors()
    }
    
    private func updateColors() {
        backgroundColor = WKAppEnvironment.current.theme.background
    }
    
// MARK: Button Actions

    @objc private func tappedBold() {
        //delegate?.textFormattingProvidingDidTapBold()
    }

    @objc private func tappedItalics() {
        //delegate?.textFormattingProvidingDidTapItalics()
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
    
    @objc private func selectBold() {
        boldButton.isSelected = true
    }
    
    @objc private func deselectBold() {
        boldButton.isSelected = false
    }
    
    @objc private func selectItalics() {
        italicsButton.isSelected = true
    }
    
    @objc private func deselectItalics() {
        italicsButton.isSelected = false
    }
}
