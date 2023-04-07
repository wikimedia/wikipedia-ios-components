import UIKit

class WKContextualHighlightEditToolbarView: WKEditToolbarView {
    @IBOutlet private weak var stackView: UIStackView!
    
    @IBOutlet weak var boldButton: WKEditToolbarButton!
    @IBOutlet weak var italicsButton: WKEditToolbarButton!
    @IBOutlet weak var formatHeadingButton: WKEditToolbarButton!
    @IBOutlet weak var citationButton: WKEditToolbarButton!
    @IBOutlet weak var linkButton: WKEditToolbarButton!
    @IBOutlet weak var templateButton: WKEditToolbarButton!
    @IBOutlet weak var clearMarkupButton: WKEditToolbarButton!
    @IBOutlet weak var showMoreButton: WKEditToolbarNavigatorButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        showMoreButton.setImage(WKIcon.plusCircleFill, for: .normal)
        boldButton.setImage(WKIcon.bold, for: .normal)
        italicsButton.setImage(WKIcon.italics, for: .normal)
        formatHeadingButton.setImage(WKIcon.style, for: .normal)
        citationButton.setImage(WKIcon.addCitation, for: .normal)
        linkButton.setImage(WKIcon.link, for: .normal)
        templateButton.setImage(WKIcon.curlyBrackets, for: .normal)
        clearMarkupButton.setImage(WKIcon.clearFormatting, for: .normal)
        
        showMoreButton.addTarget(self, action: #selector(tappedShowMoreButton), for: .touchUpInside)
        boldButton.addTarget(self, action: #selector(toggleBoldSelection), for: .touchUpInside)
        italicsButton.addTarget(self, action: #selector(toggleItalicSelection), for: .touchUpInside)
        formatHeadingButton.addTarget(self, action: #selector(formatHeader), for: .touchUpInside)
        citationButton.addTarget(self, action: #selector(toggleReferenceSelection), for: .touchUpInside)
        linkButton.addTarget(self, action: #selector(toggleAnchorSelection), for: .touchUpInside)
        templateButton.addTarget(self, action: #selector(toggleTemplate), for: .touchUpInside)
        clearMarkupButton.addTarget(self, action: #selector(clearFormatting), for: .touchUpInside)
    }

    @objc func toggleBoldSelection(_ sender: UIButton) {
        //delegate?.textFormattingProvidingDidTapBold()
    }

    @objc func toggleItalicSelection(_ sender: UIButton) {
        //delegate?.textFormattingProvidingDidTapItalics()
    }

    @objc func formatHeader(_ sender: UIButton) {
        //delegate?.textFormattingProvidingDidTapTextStyleFormatting()
    }

    @objc func toggleReferenceSelection(_ sender: UIButton) {
        //delegate?.textFormattingProvidingDidTapReference()
    }

    @objc func toggleAnchorSelection(_ sender: UIButton) {
        //delegate?.textFormattingProvidingDidTapLink()
    }

    @objc func toggleTemplate(sender: UIButton) {
        //delegate?.textFormattingProvidingDidTapTemplate()
    }

    @objc func clearFormatting(sender: UIButton) {
        //delegate?.textFormattingProvidingDidTapClearFormatting()
    }

    @objc func tappedShowMoreButton(_ sender: UIButton) {
        //delegate?.textFormattingProvidingDidTapTextFormatting()
    }
}
