import Foundation

public final class WKWatchlistViewModel {

	// MARK: - Nested Types

	public struct LocalizedStrings {
		public var title: String
		public var filter: String

		public init(title: String, filter: String) {
			self.title = title
			self.filter = filter
		}
	}
    
    public struct Configuration {
        let showNavBarUponAppearance: Bool
        let hideNavBarUponDisappearance: Bool
        
        public init(showNavBarUponAppearance: Bool = false, hideNavBarUponDisappearance: Bool = false) {
            self.showNavBarUponAppearance = showNavBarUponAppearance
            self.hideNavBarUponDisappearance = hideNavBarUponDisappearance
        }
    }

	// MARK: - Properties

	var localizedStrings: LocalizedStrings
    let configuration: Configuration

	// MARK: - Lifecycle

    public init(localizedStrings: LocalizedStrings, configuration: Configuration) {
		self.localizedStrings = localizedStrings
        self.configuration = configuration
	}
	
}
