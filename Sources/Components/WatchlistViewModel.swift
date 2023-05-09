import Foundation
import WKData

public class WatchlistItemViewModel {

    public let title: String
    
    init(title: String) {
        self.title = title
    }
}

public class WatchlistViewModel {
    private let watchlistService: WatchlistService
    
    public init(fetcher: WatchlistFetching) {
        self.watchlistService = WatchlistService(fetcher: fetcher)
    }
    
    public func fetchWatchlist(completion: (Result<[WatchlistItemViewModel], Error>) -> Void) {
        watchlistService.fetchWatchlist { result in
            switch result {
            case .success(let items):
                let itemViewModels = items.map { WatchlistItemViewModel(title: $0.title) }
                completion(.success(itemViewModels))
            case .failure(let error):
                completion(.failure(error))
                                                                    
            }
        }
    }
}
