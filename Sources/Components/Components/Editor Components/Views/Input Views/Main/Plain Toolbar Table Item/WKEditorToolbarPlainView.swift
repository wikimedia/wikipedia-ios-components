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
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectionStateChanged(_:)), name: Notification.sourceEditorButtonSelectionStateChanged, object: nil)
    }
    
    private func updateColors() {
        backgroundColor = WKAppEnvironment.current.theme.background
    }
    
    // MARK:  Button Actions
    
    override func appEnvironmentDidChange() {
        super.appEnvironmentDidChange()
        updateColors()
    }
    
    @objc func tappedBold() {
        //delegate?.textFormattingProvidingDidTapBold()
    }

    @objc func tappedItalics() {
        //delegate?.textFormattingProvidingDidTapItalics()
    }

    @objc func tappedCitation() {
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
    
    // MARK: Notifications
        
    @objc private func selectionStateChanged(_ note: Notification) {
        guard let selectionStates = note.userInfo?[String.WKSourceEditorButtonSelectionStateKey] as? WKSourceEditorInputButtonSelectedStates else {
            return
        }
        boldButton.isSelected = selectionStates.isBoldSelected
        italicsButton.isSelected = selectionStates.isItalicsSelected
    }
}
