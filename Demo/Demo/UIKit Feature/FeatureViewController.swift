import UIKit

class FeatureViewController: UIViewController {
    
    let viewModel: FeatureViewModel
    
    lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    var featureView: FeatureView {
        return view as! FeatureView
    }
    
    init(viewModel: FeatureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let featureView = FeatureView()
        view = featureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingView()

        loadingView.start()
        viewModel.fetchItems { result in
            
            self.loadingView.stop()
            
            switch result {
            case .success:
                // Same idea here as calling collectionView.reloadData from the view controller, I just didn't want to bother with a collection view for mock UI.
                self.featureView.dataView.configure(items: self.viewModel.items)
                self.featureView.updateEmptyView(isVisible: self.viewModel.items.isEmpty)
            default:
                break
            }
            
            self.featureView.updateErrorView(isVisible: self.viewModel.error != nil)
        }
        
        view.backgroundColor = .white
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: loadingView.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor),
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor)
        ])
    }
}

