import UIKit

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
        
        clearMarkupButton.setImage(WKIcon.clearFormatting, for: .normal)
        clearMarkupButton.addTarget(self, action: #selector(tappedClearFormatting), for: .touchUpInside)
        
        showMoreButton.setImage(WKIcon.plusCircleFill, for: .normal)
        showMoreButton.addTarget(self, action: #selector(tappedShowMore), for: .touchUpInside)
    }

    @objc func tappedBold() {
        //delegate?.textFormattingProvidingDidTapBold()
    }

    @objc func tappedItalics() {
        //delegate?.textFormattingProvidingDidTapItalics()
    }

    @objc func tappedFormatHeading() {
        //delegate?.textFormattingProvidingDidTapTextStyleFormatting()
    }

    @objc func tappedCitation() {
        //delegate?.textFormattingProvidingDidTapReference()
    }

    @objc func tappedLink() {
        //delegate?.textFormattingProvidingDidTapLink()
    }

    @objc func tappedTemplate() {
        //delegate?.textFormattingProvidingDidTapTemplate()
    }

    @objc func tappedClearFormatting() {
        //delegate?.textFormattingProvidingDidTapClearFormatting()
    }

    @objc func tappedShowMore() {
        //delegate?.textFormattingProvidingDidTapTextFormatting()
    }
}
