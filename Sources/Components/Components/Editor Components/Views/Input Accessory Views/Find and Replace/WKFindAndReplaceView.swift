import UIKit

class WKFindAndReplaceView: WKComponentView {
    
    // MARK: - IBOutlet Properties

    @IBOutlet private var outerStackViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var outerStackViewTrailingConstraint: NSLayoutConstraint!
    
    // Find outlets
    @IBOutlet private var findStackView: UIStackView!
    @IBOutlet private var nextPrevButtonStackView: UIStackView!
    @IBOutlet private var findTextField: UITextField!
    @IBOutlet private var currentMatchLabel: UILabel!
    @IBOutlet private var findClearButton: UIButton!
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var previousButton: UIButton!
    @IBOutlet private var magnifyImageView: UIImageView!
   
    // Replace outlets
    @IBOutlet private var replaceStackView: UIStackView!
    @IBOutlet private var replaceTextField: UITextField!
    @IBOutlet private var replaceTypeLabel: UILabel!
    @IBOutlet private var replacePlaceholderLabel: UILabel!
    @IBOutlet private var replaceClearButton: UIButton!
    @IBOutlet private var replaceButton: UIButton!
    @IBOutlet private var replaceSwitchButton: UIButton!
    @IBOutlet private var pencilImageView: UIImageView!
    
    // MARK: - Other Properties
    
    private var viewModel = ViewModel()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        closeButton.setImage(WKIcon.close, for: .normal)
        previousButton.setImage(WKIcon.chevonUp, for: .normal)
        nextButton.setImage(WKIcon.chevonDown, for: .normal)
        
        replaceButton.setImage(WKIcon.replace, for: .normal)
        replaceSwitchButton.setImage(WKIcon.more, for: .normal)
        
        magnifyImageView.image = WKIcon.find
        pencilImageView.image = WKIcon.pencil
        
        findClearButton.setImage(WKIcon.closeCircleFill, for: .normal)
        replaceClearButton.setImage(WKIcon.closeCircleFill, for: .normal)
        
        currentMatchLabel.adjustsFontForContentSizeCategory = true
        currentMatchLabel.font = WKFont.for(.smallHeadline, compatibleWith: appEnvironment.traitCollection)
        replaceTypeLabel.adjustsFontForContentSizeCategory = true
        replaceTypeLabel.font = WKFont.for(.smallHeadline, compatibleWith: appEnvironment.traitCollection)
        replacePlaceholderLabel.adjustsFontForContentSizeCategory = true
        replacePlaceholderLabel.font = WKFont.for(.smallHeadline, compatibleWith: appEnvironment.traitCollection)
        
        configure(viewModel: viewModel)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 46)
    }
    
    // MARK: - Public
    
    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        updateConfiguration(configuration: viewModel.configuration)
        updateReplaceViewModel(replaceViewModel: viewModel.replaceViewModel)
        updateFindViewModel(findViewModel: viewModel.findViewModel)
    }
    
    func close() {
        resetFind()
        resetReplace()
    }
    
    // MARK: IBActions
    
    @IBAction func tappedFindClear() {
        //delegate?.keyboardBarDidTapClear(self)
    }
    
    @IBAction func tappedReplaceClear() {
        viewModel.resetReplaceText()
        configure(viewModel: viewModel)
    }
    
    @IBAction func tappedClose() {
        //delegate?.keyboardBarDidTapClose(self)
    }
    
    @IBAction func tappedNext() {
        //delegate?.keyboardBarDidTapNext(self)
    }
    
    @IBAction func tappedPrevious() {
        //delegate?.keyboardBarDidTapPrevious(self)
    }
    
    @IBAction func tappedReplace() {
        
        guard let replaceText = replaceTextField.text else {
            return
        }
        //delegate?.keyboardBarDidTapReplace(self, replaceText: replaceText, replaceType: replaceType)
    }
    
    @IBAction func tappedReplaceSwitch() {
        //displayDelegate?.keyboardBarDidTapReplaceSwitch(self)
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        switch sender {
        case findTextField:
            viewModel.update(findText: sender.text)
            configure(viewModel: viewModel)
        case replaceTextField:
            viewModel.update(replaceText: sender.text)
            configure(viewModel: viewModel)
        default:
            break
        }
        
        //delegate?.keyboardBar(self, didChangeSearchTerm: findTextField.text)
    }
}

// MARK: UITextFieldDelegate

extension WKFindAndReplaceView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case findTextField:
             //delegate?.keyboardBarDidTapReturn(self)
            return true
        case replaceTextField:
            
            return viewModel.replaceKeyboardShouldReturn
            
            //delegate?.keyboardBarDidTapReplace(self, replaceText: replaceText, replaceType: replaceType)
        default:
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === replaceTextField {
            viewModel.update(replaceText: textField.text, replaceTextFieldIsFirstResponder: true)
        } else if textField === findTextField {
            viewModel.update(findText: textField.text, replaceTextFieldIsFirstResponder: false)
        }
        
        configure(viewModel: viewModel)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === replaceTextField {
            viewModel.update(replaceTextFieldIsFirstResponder: false)
        }
        
        configure(viewModel: viewModel)
    }
}

// MARK: Private

private extension WKFindAndReplaceView {
    
    func resetFind() {
        viewModel.resetFind()
        configure(viewModel: viewModel)
    }
    
    func resetReplace() {
        viewModel.resetReplace()
        configure(viewModel: viewModel)
    }
    
    func updateFindViewModel(findViewModel: FindViewModel) {
        self.currentMatchLabel.text = findViewModel.resultsDescription
        self.findTextField.text = findViewModel.text
        self.previousButton.isEnabled = findViewModel.previousButtonIsEnabled
        self.nextButton.isEnabled = findViewModel.nextButtonIsEnabled
        self.findClearButton.isHidden = findViewModel.findClearButtonIsHidden
    }
    
    func updateReplaceViewModel(replaceViewModel: ReplaceViewModel) {
        replaceTextField.text = replaceViewModel.text
        replacePlaceholderLabel.text = replaceViewModel.placeholderText
        replacePlaceholderLabel.isHidden = replaceViewModel.placeholderLabelIsHidden
        replaceTypeLabel.text = replaceViewModel.typeLabelText
        replaceTypeLabel.isHidden = replaceViewModel.typeLabelIsHidden
        replaceButton.isEnabled = replaceViewModel.replaceButtonIsEnabled
        replaceClearButton.isHidden = replaceViewModel.replaceClearButtonIsHidden
    }
    
    func updateConfiguration(configuration: Configuration) {
        
        switch configuration {
        case .findOnly:
            replaceStackView.isHidden = true
            closeButton.isHidden = false
            findStackView.insertArrangedSubview(nextPrevButtonStackView, at: 0)
            outerStackViewLeadingConstraint.constant = 10
            outerStackViewTrailingConstraint.constant = 5
            accessibilityElements = [previousButton, nextButton, findTextField, currentMatchLabel, findClearButton, closeButton].compactMap { $0 as Any }
        case .findAndReplace:
            replaceStackView.isHidden = false
            closeButton.isHidden = true
            findStackView.addArrangedSubview(nextPrevButtonStackView)
            outerStackViewLeadingConstraint.constant = 18
            outerStackViewTrailingConstraint.constant = 18
            accessibilityElements = [findTextField, currentMatchLabel, findClearButton, previousButton, nextButton, replaceTextField, replaceClearButton, replaceButton, replaceSwitchButton].compactMap { $0 as Any }
        }
    }
}
