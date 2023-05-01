import Foundation

class WKEditorToolbarGroupedView: WKEditorToolbarView {
    
    @IBOutlet weak var unorderedListButton: WKEditorToolbarButton!
    @IBOutlet weak var orderedListButton: WKEditorToolbarButton!
    @IBOutlet weak var decreaseIndentButton: WKEditorToolbarButton!
    @IBOutlet weak var increaseIndentButton: WKEditorToolbarButton!
    @IBOutlet weak var superscriptButton: WKEditorToolbarButton!
    @IBOutlet weak var subscriptButton: WKEditorToolbarButton!
    @IBOutlet weak var underlineButton: WKEditorToolbarButton!
    @IBOutlet weak var strikethroughButton: WKEditorToolbarButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        unorderedListButton.setImage(WKIcon.unorderedList, for: .normal)
        unorderedListButton.addTarget(self, action: #selector(tappedUnorderedList), for: .touchUpInside)
        
        orderedListButton.setImage(WKIcon.orderedList, for: .normal)
        orderedListButton.addTarget(self, action: #selector(tappedOrderedList), for: .touchUpInside)
        
        decreaseIndentButton.setImage(WKIcon.decreaseIndent, for: .normal)
        decreaseIndentButton.addTarget(self, action: #selector(tappedDecreaseIndent), for: .touchUpInside)
        
        increaseIndentButton.setImage(WKIcon.increaseIndent, for: .normal)
        increaseIndentButton.addTarget(self, action: #selector(tappedIncreaseIndent), for: .touchUpInside)
        
        superscriptButton.setImage(WKIcon.superscript, for: .normal)
        superscriptButton.addTarget(self, action: #selector(tappedSuperscript), for: .touchUpInside)
        
        subscriptButton.setImage(WKIcon.subscript, for: .normal)
        subscriptButton.addTarget(self, action: #selector(tappedSubscript), for: .touchUpInside)
        
        underlineButton.setImage(WKIcon.underline, for: .normal)
        underlineButton.addTarget(self, action: #selector(tappedUnderline), for: .touchUpInside)
        
        strikethroughButton.setImage(WKIcon.strikethrough, for: .normal)
        strikethroughButton.addTarget(self, action: #selector(tappedStrikethrough), for: .touchUpInside)
        updateColors()
    }
    
    private func updateColors() {
        backgroundColor = WKAppEnvironment.current.theme.background
    }
    
    override func appEnvironmentDidChange() {
        super.appEnvironmentDidChange()
        updateColors()
    }
    
    @objc func tappedIncreaseIndent() {
        increaseIndentButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapIncreaseIndent()
    }
    @objc func tappedDecreaseIndent() {
        decreaseIndentButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapDecreaseIndent()
    }
    @objc func tappedUnorderedList() {
        unorderedListButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapUnorderedList()
    }
    @objc func tappedOrderedList() {
        orderedListButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapOrderedList()
    }
    @objc func tappedSuperscript() {
        superscriptButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapSuperscript()
    }
    @objc func tappedSubscript() {
        subscriptButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapSubscript()
    }
    @objc func tappedUnderline() {
        underlineButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapUnderline()
    }
    @objc func tappedStrikethrough() {
        strikethroughButton.isSelected.toggle()
        //delegate?.textFormattingProvidingDidTapStrikethrough()
    }
}
