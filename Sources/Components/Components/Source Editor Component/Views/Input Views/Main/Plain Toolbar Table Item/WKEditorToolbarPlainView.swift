import Foundation

class WKEditorToolbarPlainView: WKEditorToolbarView {
    
    @IBOutlet weak var boldButton: WKEditorToolbarButton!
    @IBOutlet weak var italicsButton: WKEditorToolbarButton!
    @IBOutlet weak var citationButton: WKEditorToolbarButton!
    @IBOutlet weak var linkButton: WKEditorToolbarButton!
    @IBOutlet weak var templateButton: WKEditorToolbarButton!
    @IBOutlet weak var commentButton: WKEditorToolbarButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        boldButton.setImage(WKIcon.bold, for: .normal)
        boldButton.addTarget(self, action: #selector(tappedBold), for: .touchUpInside)
        
        italicsButton.setImage(WKIcon.italics, for: .normal)
        italicsButton.addTarget(self, action: #selector(tappedItalics), for: .touchUpInside)
        
        citationButton.setImage(WKIcon.citation, for: .normal)
        citationButton.addTarget(self, action: #selector(tappedReference), for: .touchUpInside)
        
        linkButton.setImage(WKIcon.link, for: .normal)
        linkButton.addTarget(self, action: #selector(tappedLink), for: .touchUpInside)
        
        templateButton.setImage(WKIcon.template, for: .normal)
        templateButton.addTarget(self, action: #selector(tappedTemplate), for: .touchUpInside)
        
        commentButton.setImage(WKIcon.comment, for: .normal)
        commentButton.addTarget(self, action: #selector(tappedComment), for: .touchUpInside)
    }
    
    @objc func tappedBold() {
        //delegate?.textFormattingProvidingDidTapBold()
    }

    @objc func tappedItalics() {
        //delegate?.textFormattingProvidingDidTapItalics()
    }

    @objc func tappedReference() {
        //delegate?.textFormattingProvidingDidTapReference()
    }

    @objc func tappedTemplate() {
        //delegate?.textFormattingProvidingDidTapTemplate()
    }

    @objc func tappedComment() {
        //delegate?.textFormattingProvidingDidTapComment()
    }

    @objc func tappedLink() {
        //delegate?.textFormattingProvidingDidTapLink()
    }
}
