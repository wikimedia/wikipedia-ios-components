import Foundation

class FeatureFetcher {
    func fetchItems(completion: @escaping (Result<[FeatureItemViewModel], Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            // Pretend we're actually fetching stuff from the network here.
            sleep(3)
            
            DispatchQueue.main.async {
                
                let items = [FeatureItemViewModel(title: "Item 1"), FeatureItemViewModel(title: "Item 2")]
                
                // Adjust comments to trigger empty and error states
                completion(.success(items))
                //completion(.success([]))
                //completion(.failure(NSError(domain: "org.wikimedia.wikipedia.ios.ui.components.demo", code: 0)))
            }
        }
    }
}
