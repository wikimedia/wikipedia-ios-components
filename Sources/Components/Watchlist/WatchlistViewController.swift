import Foundation

public final class WatchlistViewController: WKCanvasViewController {
    
    private let viewModel: WatchlistViewModel
    
    public init(viewModel: WatchlistViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchWatchlist { result in
            switch result {
            case .success(let items):
                print(items.map { $0.title })
            case .failure(let error):
                print(error)
            }
        }
    }
}
