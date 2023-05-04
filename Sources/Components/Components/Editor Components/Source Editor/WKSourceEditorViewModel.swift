import Foundation

public class WKSourceEditorViewModel {
    
    // MARK: - Nested Types
    
    public enum Configuration: String {
        case short
        case full
    }
    
    // MARK: - Properties
    
    public var configuration: Configuration
    public let initialText: String
    public var isSyntaxHighlightingEnabled: Bool
    
    // MARK: - Public

    public init(configuration: Configuration, initialText: String, isSyntaxHighlightingEnabled: Bool) {
        self.configuration = configuration
        self.initialText = initialText
        self.isSyntaxHighlightingEnabled = isSyntaxHighlightingEnabled
    }
}

// 4.5 - change input view in proper way
// 6. Add selection states
// 8. Fix spacing.
// 5. Add acccessibility strings
// 7. better theming.



//rules:

//if you need a view model (say, need to fetch data, or need view state to change), make one. If you need a configuration (should be an unchanging enum), make it a part of the view model. Or component can be instantiated with just a configuration if view model feels unnecesssary. Made strings as a separate part of all of that, I guess.
