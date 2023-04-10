import Foundation

class WKGroupedToolbarView: WKEditToolbarView {
    
    @IBOutlet weak var unorderedListButton: WKEditToolbarButton!
    @IBOutlet weak var orderedListButton: WKEditToolbarButton!
    @IBOutlet weak var decreaseIndentButton: WKEditToolbarButton!
    @IBOutlet weak var increaseIndentButton: WKEditToolbarButton!
    @IBOutlet weak var superscriptButton: WKEditToolbarButton!
    @IBOutlet weak var subscriptButton: WKEditToolbarButton!
    @IBOutlet weak var underlineButton: WKEditToolbarButton!
    @IBOutlet weak var strikethroughButton: WKEditToolbarButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        unorderedListButton.setImage(WKIcon.unorderedList, for: .normal)
        orderedListButton.setImage(WKIcon.orderedList, for: .normal)
        decreaseIndentButton.setImage(WKIcon.decreaseIndent, for: .normal)
        increaseIndentButton.setImage(WKIcon.increaseIndent, for: .normal)
        superscriptButton.setImage(WKIcon.sup, for: .normal)
        subscriptButton.setImage(WKIcon.sub, for: .normal)
        underlineButton.setImage(WKIcon.underline, for: .normal)
        strikethroughButton.setImage(WKIcon.strikethrough, for: .normal)

        unorderedListButton.addTarget(self, action: #selector(tappedUnorderedList), for: .touchUpInside)
        orderedListButton.addTarget(self, action: #selector(tappedOrderedList), for: .touchUpInside)
        decreaseIndentButton.addTarget(self, action: #selector(tappedDecreaseIndent), for: .touchUpInside)
        increaseIndentButton.addTarget(self, action: #selector(tappedIncreaseIndent), for: .touchUpInside)
        superscriptButton.addTarget(self, action: #selector(tappedSuperscript), for: .touchUpInside)
        subscriptButton.addTarget(self, action: #selector(tappedSubscript), for: .touchUpInside)
        underlineButton.addTarget(self, action: #selector(tappedUnderline), for: .touchUpInside)
        strikethroughButton.addTarget(self, action: #selector(tappedStrikethrough), for: .touchUpInside)
    }
    
    @objc func tappedIncreaseIndent() {
        //delegate?.textFormattingProvidingDidTapIncreaseIndent()
    }
    @objc func tappedDecreaseIndent() {
        //delegate?.textFormattingProvidingDidTapDecreaseIndent()
    }
    @objc func tappedUnorderedList() {
        //delegate?.textFormattingProvidingDidTapUnorderedList()
    }
    @objc func tappedOrderedList() {
        //delegate?.textFormattingProvidingDidTapOrderedList()
    }
    @objc func tappedSuperscript() {
        //delegate?.textFormattingProvidingDidTapSuperscript()
    }
    @objc func tappedSubscript() {
        //delegate?.textFormattingProvidingDidTapSubscript()
    }
    @objc func tappedUnderline() {
        //delegate?.textFormattingProvidingDidTapUnderline()
    }
    @objc func tappedStrikethrough() {
        //delegate?.textFormattingProvidingDidTapStrikethrough()
    }
}
