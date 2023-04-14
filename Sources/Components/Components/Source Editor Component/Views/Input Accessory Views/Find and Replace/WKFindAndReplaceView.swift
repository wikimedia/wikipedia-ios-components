import UIKit

class WKFindAndReplaceView: WKComponentView {
    
    // MARK: - Nested Types

    struct FindViewModel: Equatable {
        var resultsCurrentIndex: UInt?
        var resultsTotal: UInt
        var resultsDescription: String?
        var text: String?
        var previousButtonIsEnabled: Bool
        var nextButtonIsEnabled: Bool
        var findClearButtonIsHidden: Bool
    }
    
    enum ReplaceType {
        case replaceSingle
        case replaceAll
    }
    
    struct ReplaceViewModel: Equatable {
        var type: ReplaceType
        var text: String?
        var placeholderText: String?
        var typeLabelText: String?
        var typeLabelIsHidden: Bool
        var textFieldIsFirstResponder: Bool
        var placeholderLabelIsHidden: Bool
        var replaceButtonIsEnabled: Bool
        var replaceClearButtonIsHidden: Bool
    }
    
    enum Configuration {
        case findOnly
        case findAndReplace
    }
    
    struct ViewModel {
        let configuration: Configuration
        var replaceViewModel: ReplaceViewModel
        var findViewModel: FindViewModel
        
        init() {
            self.configuration = .findAndReplace
            self.replaceViewModel = ReplaceViewModel(type: .replaceSingle, text: nil, placeholderText: "Replace with…", typeLabelText: nil, typeLabelIsHidden: false, textFieldIsFirstResponder: false, placeholderLabelIsHidden: false, replaceButtonIsEnabled: false, replaceClearButtonIsHidden: true)
            self.findViewModel = FindViewModel(resultsCurrentIndex: nil, resultsTotal: 0, resultsDescription: nil, text: nil, previousButtonIsEnabled: false, nextButtonIsEnabled: false, findClearButtonIsHidden: true)
        }
        
        var replaceKeyboardShouldReturn: Bool {
            guard let replaceText = replaceViewModel.text,
                  let findText = findViewModel.text,
                  findViewModel.resultsTotal > 0,
                  findText.count > 0,
                replaceText.count > 0 else {
                return false
            }
            
            return true
        }
    }

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
    
    func show() {
        findTextField.becomeFirstResponder()
    }
    
    func hide() {
        findTextField.resignFirstResponder()
        replaceTextField.resignFirstResponder()
    }
    
    func reset() {
        resetFind()
        resetReplace()
    }
    
    // MARK: IBActions
    
    @IBAction func tappedFindClear() {
        //delegate?.keyboardBarDidTapClear(self)
    }
    
    @IBAction func tappedReplaceClear() {
        viewModel.replaceViewModel.text = nil
        syncReplaceViewModel()
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
            viewModel.findViewModel.text = sender.text
            syncFindViewModel()
            configure(viewModel: viewModel)
        case replaceTextField:
            viewModel.replaceViewModel.text = sender.text
            syncReplaceViewModel()
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
            viewModel.replaceViewModel.textFieldIsFirstResponder = true
            viewModel.replaceViewModel.text = textField.text
        } else if textField === findTextField {
            viewModel.replaceViewModel.textFieldIsFirstResponder = false
            viewModel.findViewModel.text = textField.text
        }
        
        syncReplaceViewModel()
        syncFindViewModel()
        configure(viewModel: viewModel)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === replaceTextField {
            viewModel.replaceViewModel.textFieldIsFirstResponder = false
        }
        
        syncReplaceViewModel()
        configure(viewModel: viewModel)
    }
}

// MARK: Private

private extension WKFindAndReplaceView {
    
    func resetFind() {
        viewModel.findViewModel.text = nil
        viewModel.findViewModel.resultsCurrentIndex = nil
        viewModel.findViewModel.resultsTotal = 0

        syncFindViewModel()
        configure(viewModel: viewModel)
    }
    
    func resetReplace() {
        viewModel.replaceViewModel.text = nil
        viewModel.replaceViewModel.type = .replaceSingle
        
        syncReplaceViewModel()
        configure(viewModel: viewModel)
    }
    
    func updateFindViewModel(findViewModel: FindViewModel) {
        self.currentMatchLabel.text = findViewModel.resultsDescription
        self.findTextField.text = findViewModel.text
        self.previousButton.isEnabled = findViewModel.previousButtonIsEnabled
        self.nextButton.isEnabled = findViewModel.nextButtonIsEnabled
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
    
    // TODO: Consider embedding this logic into
    
    func syncFindViewModel() {
        let index = viewModel.findViewModel.resultsCurrentIndex
        let total =  viewModel.findViewModel.resultsTotal
        if viewModel.findViewModel.resultsCurrentIndex == nil && total > 0 {
            viewModel.findViewModel.resultsDescription = String.localizedStringWithFormat("%lu", total)
        } else if let index {
            let format = "%1$@ / %2$@"
            viewModel.findViewModel.resultsDescription = String.localizedStringWithFormat(format, NSNumber(value: index), NSNumber(value: total))
        } else {
            viewModel.findViewModel.resultsDescription = nil
        }
        
        viewModel.findViewModel.previousButtonIsEnabled = total >= 2
        viewModel.findViewModel.nextButtonIsEnabled = total >= 2
        
        viewModel.findViewModel.findClearButtonIsHidden = (viewModel.findViewModel.text?.count ?? 0) == 0
    }
    
    func syncReplaceViewModel() {
        let count = viewModel.replaceViewModel.text?.count ?? 0
        
        switch (viewModel.replaceViewModel.textFieldIsFirstResponder, count) {
        case (false, 0):
            viewModel.replaceViewModel.typeLabelText = nil
            viewModel.replaceViewModel.typeLabelIsHidden = true
            viewModel.replaceViewModel.placeholderLabelIsHidden = false
        case (true, 0):
            viewModel.replaceViewModel.typeLabelText = nil
            viewModel.replaceViewModel.typeLabelIsHidden = true
            viewModel.replaceViewModel.placeholderLabelIsHidden = true
        case (_, 1...):
            viewModel.replaceViewModel.typeLabelText = viewModel.replaceViewModel.type == .replaceSingle ? "Replace" : "Replace All"
            viewModel.replaceViewModel.typeLabelIsHidden = false
            viewModel.replaceViewModel.placeholderLabelIsHidden = true
        default:
            assertionFailure("Unexpected replace label state")
        }
        
        viewModel.replaceViewModel.replaceButtonIsEnabled = count > 0 && viewModel.findViewModel.resultsTotal > 0 && replaceTextField.text != findTextField.text
        viewModel.replaceViewModel.replaceClearButtonIsHidden = count == 0
    }
}
