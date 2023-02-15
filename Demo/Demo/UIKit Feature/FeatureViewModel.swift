import Foundation

class FeatureViewModel {
    
    private let fetcher = FeatureFetcher()
    
    private(set) var items: [FeatureItemViewModel] = []
    private(set) var error: Error?
    
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
