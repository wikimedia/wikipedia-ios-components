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
// 3. components can be given: 1. configuration. generally an enum, to tell it to do something different. unchangeable once set once. 2. view model, which can be changeable and the view reacts. 3. strings struct. view within can change decide to do different things with them depending on configuration / view model.
// 4. rename classes of WKEdit_ with WKEditor_. Anything super general apart from an editor (WKToolbarSeparatorView) could stay as-is.
// 4.5 - change input view in proper way
// 4.75 - add find in page.
// 5. Add more strings, acccessibility
// 6. Add selection states
// 7. Add theming.
// 8. Fix spacing.


//rules:

//if you need a view model (say, need to fetch data, or need view state to change), make one. If you need a configuration (generally an enum, unchanging), make it a part of the view model. Or component can be instantiated with just a configuration if view model feels unnecesssary. Made strings as a separate part of all of that, I guess.
