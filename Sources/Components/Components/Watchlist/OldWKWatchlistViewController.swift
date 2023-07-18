import Foundation
import UIKit

public final class OldWKWatchlistViewController: WKCanvasViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private func generateLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func generateButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func generateHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }
    
    let viewModel: OldWKWatchlistViewModel
    
    public init(viewModel: OldWKWatchlistViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialViews()
        fetchWatchlist()
    }
    
    private func setupInitialViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func fetchWatchlist() {
        viewModel.fetchWatchlist { [weak self] in
            self?.displayWatchlistItems()
        }
    }
    
    private func displayWatchlistItems() {

        for (index, item) in viewModel.items.enumerated() {
            
            let hStackView = generateHorizontalStackView()
            
            let titleLabel = generateLabel()
            titleLabel.text = item.title
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)
            
            let revIDLabel = generateLabel()
            revIDLabel.text = String(item.revisionID)
            revIDLabel.setContentHuggingPriority(.required, for: .horizontal)
            
            let usernameLabel = generateLabel()
            usernameLabel.text = String(item.username)
            usernameLabel.setContentHuggingPriority(.required, for: .horizontal)
            
            let button = generateButton()
            button.setTitle("Actions", for: .normal)
            button.setTitleColor(WKAppEnvironment.current.theme.link, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(tappedButton(sender:)), for: .touchUpInside)
            button.setContentHuggingPriority(.defaultLow, for: .horizontal)
            
            hStackView.addArrangedSubview(titleLabel)
            hStackView.addArrangedSubview(revIDLabel)
            hStackView.addArrangedSubview(usernameLabel)
            hStackView.addArrangedSubview(button)
            stackView.addArrangedSubview(hStackView)
        }
    }
    
    @objc private func tappedButton(sender: UIButton) {
        let item = viewModel.items[sender.tag]
        
        viewModel.fetchWatchStatus(item) { result in
            switch result {
            case .success(let status):
                self.presentActionSheetForItem(item, isWatched: status.watched, hasRollbackRights: status.userHasRollbackRights ?? false)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func presentActionSheetForItem(_ item: OldWKWatchlistViewModel.ItemViewModel, isWatched: Bool, hasRollbackRights: Bool) {
        
        let alert = UIAlertController(title: item.title, message: "Please Select an Option", preferredStyle: .actionSheet)
        
        if isWatched {
            alert.addAction(UIAlertAction(title: "Unwatch", style: .default , handler:{ (UIAlertAction)in
                self.unwatchItem(item)
            }))
            
            alert.addAction(UIAlertAction(title: "Update expiry to never", style: .default , handler:{ (UIAlertAction)in
                self.updateItemExpiryToNever(item)
            }))
            
            alert.addAction(UIAlertAction(title: "Update expiry to one week", style: .default, handler:{ (UIAlertAction)in
                self.updateItemExpiryToOneWeek(item)
            }))
            
            alert.addAction(UIAlertAction(title: "Update expiry to one month", style: .default, handler:{ (UIAlertAction)in
                self.updateItemExpiryToOneMonth(item)
            }))
            
            alert.addAction(UIAlertAction(title: "Update expiry to three months", style: .default, handler:{ (UIAlertAction)in
                self.updateItemExpiryToThreeMonths(item)
            }))
            
            alert.addAction(UIAlertAction(title: "Update expiry to six months", style: .default, handler:{ (UIAlertAction)in
                self.updateItemExpiryToSixMonths(item)
            }))
            
        } else {
            alert.addAction(UIAlertAction(title: "Watch", style: .default , handler:{ (UIAlertAction)in
                self.watchItem(item)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            //
        }))

        present(alert, animated: true)
    }
    
    private func watchItem(_ item: OldWKWatchlistViewModel.ItemViewModel) {
        viewModel.watchItem(item, expiry: .never)
    }
    
    private func unwatchItem(_ item: OldWKWatchlistViewModel.ItemViewModel) {
        viewModel.unwatchItem(item)
    }
    
    private func updateItemExpiryToNever(_ item: OldWKWatchlistViewModel.ItemViewModel) {
        viewModel.watchItem(item, expiry: .never)
    }
    
    private func updateItemExpiryToOneWeek(_ item: OldWKWatchlistViewModel.ItemViewModel) {
        viewModel.watchItem(item, expiry: .oneWeek)
    }
    
    private func updateItemExpiryToOneMonth(_ item: OldWKWatchlistViewModel.ItemViewModel) {
        viewModel.watchItem(item, expiry: .oneMonth)
    }
    
    private func updateItemExpiryToThreeMonths(_ item: OldWKWatchlistViewModel.ItemViewModel) {
        viewModel.watchItem(item, expiry: .threeMonths)
    }
    
    private func updateItemExpiryToSixMonths(_ item: OldWKWatchlistViewModel.ItemViewModel) {
        viewModel.watchItem(item, expiry: .sixMonths)
    }
}
