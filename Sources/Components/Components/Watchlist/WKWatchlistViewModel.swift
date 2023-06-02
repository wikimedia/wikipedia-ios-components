import Foundation
import WKData

public class WKWatchlistViewModel {
    
    class ItemViewModel {
        let title: String
        let revisionID: UInt
        let project: WKProject
        
        internal init(title: String, revisionID: UInt, project: WKProject) {
            self.title = title
            self.revisionID = revisionID
            self.project = project
        }
    }
    
    private let service = WKWatchlistService()
    private(set) var items: [ItemViewModel] = []
    
    public init() {
        
    }
    
    func fetchWatchlist(completion: @escaping () -> Void) {
        service.fetchWatchlist { result in
            DispatchQueue.main.async {
                defer {
                    completion()
                }
                
                switch result {
                case .success(let watchlist):
                    self.items = watchlist.items.map { ItemViewModel(title: $0.title, revisionID: $0.revisionID, project: $0.project) }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func watchItem(_ item: ItemViewModel, expiry: WKWatchlistExpiryType) {
        service.watch(title: item.title, project: item.project, expiry: expiry) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    print("success!")
                case .failure(let error):
                    print("fail! \(error)")
                }
            }
        }
    }
    
    func unwatchItem(_ item: ItemViewModel) {
        service.unwatch(title: item.title, project: item.project) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    print("success!")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func fetchWatchStatus(_ item: ItemViewModel, completion: @escaping (Result<WKPageWatchStatus, Error>) -> Void) {
        service.fetchWatchStatus(title: item.title, project: item.project, needsRollbackRights: true) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func undoRevision(_ item: ItemViewModel) {
        print("not implemented yet")
    }
    
    func rollbackRevision(_ item: ItemViewModel) {
        print("not implemented yet")
    }
}
