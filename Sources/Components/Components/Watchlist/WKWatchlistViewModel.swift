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
    
    public struct PresentationConfiguration {
        let showNavBarUponAppearance: Bool
        let hideNavBarUponDisappearance: Bool
        
        public init(showNavBarUponAppearance: Bool = false, hideNavBarUponDisappearance: Bool = false) {
            self.showNavBarUponAppearance = showNavBarUponAppearance
            self.hideNavBarUponDisappearance = hideNavBarUponDisappearance
        }
    }

	// MARK: - Properties

	var localizedStrings: LocalizedStrings
    let presentationConfiguration: PresentationConfiguration

	// MARK: - Lifecycle

    public init(localizedStrings: LocalizedStrings, presentationConfiguration: PresentationConfiguration) {
		self.localizedStrings = localizedStrings
        self.presentationConfiguration = presentationConfiguration
	}
	
}
