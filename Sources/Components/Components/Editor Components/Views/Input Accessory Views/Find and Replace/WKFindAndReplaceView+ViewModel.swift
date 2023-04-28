import Foundation

extension WKFindAndReplaceView {
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
        
        mutating func resetReplaceText() {
            replaceViewModel.text = nil
            syncReplaceViewModel()
        }
        
        mutating func resetReplace() {
            replaceViewModel.text = nil
            replaceViewModel.type = .replaceSingle
            syncReplaceViewModel()
        }
        
        mutating func resetFind() {
            findViewModel.text = nil
            findViewModel.resultsCurrentIndex = nil
            findViewModel.resultsTotal = 0
            syncFindViewModel()
        }
        
        mutating func update(findText: String? = nil, findResultsCurrentIndex: UInt? = nil, findResultsTotal: UInt? = nil, replaceText: String? = nil, replaceTextFieldIsFirstResponder: Bool? = nil, replaceType: ReplaceType? = nil) {
            if let findText {
                findViewModel.text = findText
            }
            
            if let findResultsCurrentIndex {
                findViewModel.resultsCurrentIndex = findResultsCurrentIndex
            }
            
            if let findResultsTotal {
                findViewModel.resultsTotal = findResultsTotal
            }
            
            syncFindViewModel()
            
            if let replaceText {
                replaceViewModel.text = replaceText
            }
            
            if let replaceTextFieldIsFirstResponder {
                replaceViewModel.textFieldIsFirstResponder = replaceTextFieldIsFirstResponder
            }
            
            if let replaceType {
                replaceViewModel.type = replaceType
            }
            
            syncReplaceViewModel()
        }
        
        private mutating func syncFindViewModel() {
            let index = findViewModel.resultsCurrentIndex
            let total =  findViewModel.resultsTotal
            if findViewModel.resultsCurrentIndex == nil && total > 0 {
                findViewModel.resultsDescription = String.localizedStringWithFormat("%lu", total)
            } else if let index {
                let format = "%1$@ / %2$@"
                findViewModel.resultsDescription = String.localizedStringWithFormat(format, NSNumber(value: index), NSNumber(value: total))
            } else {
                findViewModel.resultsDescription = nil
            }
            
            findViewModel.previousButtonIsEnabled = total >= 2
            findViewModel.nextButtonIsEnabled = total >= 2
            
            findViewModel.findClearButtonIsHidden = (findViewModel.text?.count ?? 0) == 0
        }
        
        private mutating func syncReplaceViewModel() {
            let count = replaceViewModel.text?.count ?? 0
            
            switch (replaceViewModel.textFieldIsFirstResponder, count) {
            case (false, 0):
                replaceViewModel.typeLabelText = nil
                replaceViewModel.typeLabelIsHidden = true
                replaceViewModel.placeholderLabelIsHidden = false
            case (true, 0):
                replaceViewModel.typeLabelText = nil
                replaceViewModel.typeLabelIsHidden = true
                replaceViewModel.placeholderLabelIsHidden = true
            case (_, 1...):
                replaceViewModel.typeLabelText = replaceViewModel.type == .replaceSingle ? "Replace" : "Replace All"
                replaceViewModel.typeLabelIsHidden = false
                replaceViewModel.placeholderLabelIsHidden = true
            default:
                assertionFailure("Unexpected replace label state")
            }
            
            replaceViewModel.replaceButtonIsEnabled = count > 0 && findViewModel.resultsTotal > 0 && replaceViewModel.text != findViewModel.text
            replaceViewModel.replaceClearButtonIsHidden = count == 0
        }
    }
}
