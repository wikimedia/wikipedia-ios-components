import Foundation

public class WKSourceEditorViewModel {
    
    // MARK: - Nested Types
    
    public enum Configuration: String {
        case short
        case full
    }
    
    // MARK: - Properties
    
    public var configuration: Configuration
    public let wikitext: String
    
    // MARK: - Public

    public init(configuration: Configuration, wikitext: String) {
        self.configuration = configuration
        self.wikitext = wikitext
    }
}
