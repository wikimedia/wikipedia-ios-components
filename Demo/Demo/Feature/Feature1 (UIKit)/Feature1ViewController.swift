import UIKit
import UIComponents

class Feature1ViewController: UIViewController, Themeable {

    let viewModel: Feature1ViewModel
    
    lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    var featureView: Feature1View {
        return view as! Feature1View
    }
    
    init(viewModel: Feature1ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let featureView = Feature1View()
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
                self.featureView.dataView.configure(items: self.viewModel.items, theme: self.viewModel.theme)
                self.featureView.updateEmptyView(isVisible: self.viewModel.items.isEmpty)
            default:
                break
            }
            
            self.featureView.updateErrorView(isVisible: self.viewModel.error != nil)
        }
        
        apply(theme: viewModel.theme)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        featureView.dataView.updateFonts()
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
    
    func apply(theme: Theme) {
        viewModel.theme = theme
        featureView.apply(theme: theme)
        loadingView.apply(theme: theme)
    }
}
