import Foundation
import WKData

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

	// MARK: - Properties

	var localizedStrings: LocalizedStrings
    private let service = WKWatchlistService()

	// MARK: - Lifecycle

	public init(localizedStrings: LocalizedStrings) {
		self.localizedStrings = localizedStrings
	}
    
    // MARK: - Public
    
    public func fetchWatchlist() {
        service.fetchWatchlist { result in
            switch result {
            case .success(let watchlist):
                print(watchlist)
            case .failure(let error):
                print(error)
            }
        }
    }
}
