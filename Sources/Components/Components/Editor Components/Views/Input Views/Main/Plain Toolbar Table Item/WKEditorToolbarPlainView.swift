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
        citationButton.addTarget(self, action: #selector(tappedCitation), for: .touchUpInside)
        
        linkButton.setImage(WKIcon.link, for: .normal)
        linkButton.addTarget(self, action: #selector(tappedLink), for: .touchUpInside)
        
        templateButton.setImage(WKIcon.template, for: .normal)
        templateButton.addTarget(self, action: #selector(tappedTemplate), for: .touchUpInside)
        
        commentButton.setImage(WKIcon.comment, for: .normal)
        commentButton.addTarget(self, action: #selector(tappedComment), for: .touchUpInside)
        
        updateColors()
    }
    
    private func updateColors() {
        backgroundColor = WKAppEnvironment.current.theme.background
    }
    
    override func appEnvironmentDidChange() {
        super.appEnvironmentDidChange()
        updateColors()
    }
    
    @objc func tappedBold() {
        boldButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapBold()
    }

    @objc func tappedItalics() {
        italicsButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapItalics()
    }

    @objc func tappedCitation() {
        citationButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapReference()
    }

    @objc func tappedTemplate() {
        templateButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapTemplate()
    }

    @objc func tappedComment() {
        commentButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapComment()
    }

    @objc func tappedLink() {
        linkButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapLink()
    }
}
