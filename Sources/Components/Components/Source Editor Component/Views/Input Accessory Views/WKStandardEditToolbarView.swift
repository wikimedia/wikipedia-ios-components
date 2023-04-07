import UIKit

class WKStandardEditToolbarView: WKEditToolbarView {
    
    // MARK: - Nested Types
    
    private enum ActionsType: CGFloat {
        case `default`
        case secondary

        static func visible(rawValue: RawValue) -> ActionsType {
            if rawValue == 0 {
                return .default
            } else {
                return .secondary
            }
        }

        static func next(rawValue: RawValue) -> ActionsType {
            if rawValue == 0 {
                return .secondary
            } else {
                return .default
            }
        }
    }
    
    // MARK: Properties
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var formatTextButton: WKEditToolbarButton!
    @IBOutlet weak var formatTextStyleButton: WKEditToolbarButton!
    @IBOutlet weak var citationButton: WKEditToolbarButton!
    @IBOutlet weak var linkButton: WKEditToolbarButton!
    @IBOutlet weak var templateButton: WKEditToolbarButton!
    @IBOutlet weak var mediaButton: WKEditToolbarButton!
    @IBOutlet weak var findInPageButton: WKEditToolbarButton!
    
    @IBOutlet weak var unorderedListButton: WKEditToolbarButton!
    @IBOutlet weak var orderedListButton: WKEditToolbarButton!
    @IBOutlet weak var decreaseIndentionButton: WKEditToolbarButton!
    @IBOutlet weak var increaseIndentionButton: WKEditToolbarButton!
    @IBOutlet weak var cursorUpButton: WKEditToolbarButton!
    @IBOutlet weak var cursorDownButton: WKEditToolbarButton!
    @IBOutlet weak var cursorLeftButton: WKEditToolbarButton!
    @IBOutlet weak var cursorRightButton: WKEditToolbarButton!
    
    @IBOutlet weak var expandButton: WKEditToolbarNavigatorButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        expandButton.isAccessibilityElement = false
        expandButton.setImage(WKIcon.chevonRightCircleFill, for: .normal)
        expandButton.addTarget(self, action: #selector(revealMoreActions), for: .touchUpInside)
        
        formatTextButton.setImage(WKIcon.textFormatting, for: .normal)
        formatTextButton.addTarget(self, action: #selector(formatText), for: .touchUpInside)
        
        formatTextStyleButton.setImage(WKIcon.style, for: .normal)
        formatTextButton.addTarget(self, action: #selector(formatTextStyle), for: .touchUpInside)
        
        citationButton.setImage(WKIcon.addCitation, for: .normal)
        citationButton.addTarget(self, action: #selector(toggleCitation), for: .touchUpInside)
        
        linkButton.setImage(WKIcon.link, for: .normal)
        linkButton.addTarget(self, action: #selector(toggleLink), for: .touchUpInside)
        
        templateButton.setImage(WKIcon.curlyBrackets, for: .normal)
        templateButton.addTarget(self, action: #selector(toggleTemplate), for: .touchUpInside)
        
        mediaButton.setImage(WKIcon.photo, for: .normal)
        mediaButton.addTarget(self, action: #selector(insertMedia), for: .touchUpInside)
        
        findInPageButton.setImage(WKIcon.find, for: .normal)
        findInPageButton.addTarget(self, action: #selector(showFindInPage), for: .touchUpInside)
        
        unorderedListButton.setImage(WKIcon.unorderedList, for: .normal)
        unorderedListButton.addTarget(self, action: #selector(toggleUnorderedList), for: .touchUpInside)
        
        orderedListButton.setImage(WKIcon.orderedList, for: .normal)
        orderedListButton.addTarget(self, action: #selector(toggleOrderedList), for: .touchUpInside)
        
        decreaseIndentionButton.setImage(WKIcon.decreaseIndent, for: .normal)
        decreaseIndentionButton.addTarget(self, action: #selector(decreaseIndentation), for: .touchUpInside)
        
        increaseIndentionButton.setImage(WKIcon.increaseIndent, for: .normal)
        increaseIndentionButton.addTarget(self, action: #selector(increaseIndentation), for: .touchUpInside)
        
        cursorUpButton.setImage(WKIcon.chevonUp, for: .normal)
        cursorUpButton.addTarget(self, action: #selector(moveCursorUp), for: .touchUpInside)
        
        cursorDownButton.setImage(WKIcon.chevonDown, for: .normal)
        cursorDownButton.addTarget(self, action: #selector(moveCursorDown), for: .touchUpInside)
        
        cursorLeftButton.setImage(WKIcon.chevonLeft, for: .normal)
        cursorLeftButton.addTarget(self, action: #selector(moveCursorLeft), for: .touchUpInside)
        
        cursorRightButton.setImage(WKIcon.chevonRight, for: .normal)
        cursorRightButton.addTarget(self, action: #selector(moveCursorRight), for: .touchUpInside)
    }

    // MARK: Button actions

    @objc func formatText(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapTextFormatting()
    }
    
    @objc func formatTextStyle(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapTextFormatting()
    }

    @objc func toggleCitation(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapReference()
    }

    @objc func toggleLink(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapLink()
    }

    @objc func toggleUnorderedList(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapUnorderedList()
    }

    @objc func toggleOrderedList(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapOrderedList()
    }

    @objc func decreaseIndentation(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapDecreaseIndent()
    }

    @objc func increaseIndentation(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapIncreaseIndent()
    }

    @objc func moveCursorUp(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapCursorUp()
    }

    @objc func moveCursorDown(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapCursorDown()
    }

    @objc func moveCursorLeft(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapCursorLeft()
    }

    @objc func moveCursorRight(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapCursorRight()
    }

    @objc func toggleTemplate(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapTemplate()
    }

    @objc func showFindInPage(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapFindInPage()
    }

    @objc func insertMedia(_ sender: WKEditToolbarButton) {
        //delegate?.textFormattingProvidingDidTapMediaInsert()
    }
    
    //MARK: - Actions

    @objc func revealMoreActions() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        let offsetX = scrollView.contentOffset.x
        let actionsType = ActionsType.next(rawValue: offsetX)
        
        let transform = CGAffineTransform.identity
        let buttonTransform: () -> Void
        let newOffsetX: CGFloat
        
        let sender = expandButton

        switch actionsType {
        case .default:
            buttonTransform = {
                sender?.transform = transform
            }
            newOffsetX = 0
        case .secondary:
            buttonTransform = {
                sender?.transform = transform.rotated(by: 180 * CGFloat.pi)
                sender?.transform = transform.rotated(by: -1 * CGFloat.pi)
            }
            newOffsetX = stackView.bounds.width / 2
        }

        let scrollViewContentOffsetChange = {
            self.scrollView.setContentOffset(CGPoint(x: newOffsetX , y: 0), animated: false)
        }

        let buttonAnimator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.7, animations: buttonTransform)
        let scrollViewAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: scrollViewContentOffsetChange)

        buttonAnimator.startAnimation()
        scrollViewAnimator.startAnimation()
    }
}
