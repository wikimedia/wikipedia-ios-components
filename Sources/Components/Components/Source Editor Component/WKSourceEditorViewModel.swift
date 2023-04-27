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

//todo tomorrow:
// 4.5 - change input view in proper way
// 4.75 - add find in page.
// 5. Add more strings, acccessibility
// 6. Add selection states
// 7. Add theming.
// 8. Fix spacing.


//rules:

//if you need a view model (say, need to fetch data, or need view state to change), make one. If you need a configuration (should be an unchanging enum), make it a part of the view model. Or component can be instantiated with just a configuration if view model feels unnecesssary. Made strings as a separate part of all of that, I guess.
