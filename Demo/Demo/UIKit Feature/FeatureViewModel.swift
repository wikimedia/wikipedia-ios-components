import Foundation
import UIComponents

class FeatureViewModel {
    
    private let fetcher = FeatureFetcher()
    let theme: Theme
    
    private(set) var items: [FeatureItemViewModel] = []
    private(set) var error: Error?
    
    init(theme: Theme) {
        self.theme = theme
    }
    
    func fetchItems(completion: @escaping (Result<Void, Error>) -> Void) {
        fetcher.fetchItems { result in
            switch result {
            case .success(let items):
                self.items = items
                completion(.success(()))
            case .failure(let error):
                self.error = error
                completion(.failure(error))
            }
        }
    }
}
