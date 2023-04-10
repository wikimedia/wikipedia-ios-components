import Foundation

class WKPlainToolbarView: WKEditToolbarView {
    
    @IBOutlet weak var boldButton: WKEditToolbarButton!
    @IBOutlet weak var italicsButton: WKEditToolbarButton!
    @IBOutlet weak var citationButton: WKEditToolbarButton!
    @IBOutlet weak var linkButton: WKEditToolbarButton!
    @IBOutlet weak var templateButton: WKEditToolbarButton!
    @IBOutlet weak var commentButton: WKEditToolbarButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        boldButton.setImage(WKIcon.bold, for: .normal)
        italicsButton.setImage(WKIcon.italics, for: .normal)
        citationButton.setImage(WKIcon.addCitation, for: .normal)
        linkButton.setImage(WKIcon.link, for: .normal)
        templateButton.setImage(WKIcon.curlyBrackets, for: .normal)
        commentButton.setImage(WKIcon.exclamation, for: .normal)
        
        boldButton.addTarget(self, action: #selector(toggleBold), for: .touchUpInside)
        italicsButton.addTarget(self, action: #selector(toggleItalic), for: .touchUpInside)
        citationButton.addTarget(self, action: #selector(toggleReference), for: .touchUpInside)
        linkButton.addTarget(self, action: #selector(toggleLink), for: .touchUpInside)
        templateButton.addTarget(self, action: #selector(toggleTemplate), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(toggleComment), for: .touchUpInside)
    }
    
    @objc func toggleBold() {
        //delegate?.textFormattingProvidingDidTapBold()
    }

    @objc func toggleItalic() {
        //delegate?.textFormattingProvidingDidTapItalics()
    }

    @objc func toggleReference() {
        //delegate?.textFormattingProvidingDidTapReference()
    }

    @objc func toggleTemplate() {
        //delegate?.textFormattingProvidingDidTapTemplate()
    }

    @objc func toggleComment() {
        //delegate?.textFormattingProvidingDidTapComment()
    }

    @objc func toggleLink() {
        //delegate?.textFormattingProvidingDidTapLink()
    }
}
