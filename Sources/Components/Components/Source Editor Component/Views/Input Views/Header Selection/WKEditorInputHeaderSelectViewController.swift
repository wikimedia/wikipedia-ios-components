import Foundation
import UIKit

class WKEditorInputHeaderSelectViewController: WKComponentViewController {
    
    typealias CellViewModel = WKEditorHeaderSelectCell.ViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    weak var delegate: WKEditorInputViewDelegate?
    
    private let reuseIdentifier = String(describing: WKEditorHeaderSelectCell.self)
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: WKIcon.close, style: .plain, target: self, action: #selector(close(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        
        tableView.register(WKEditorHeaderSelectCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func close(_ sender: UIBarButtonItem) {
        delegate?.didTapClose()
    }
}

extension WKEditorInputHeaderSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let headerCell = cell as? WKEditorHeaderSelectCell {
            switch indexPath.row {
            case 0:
                headerCell.configure(viewModel: CellViewModel(configuration: .paragraph, isSelected: true))
            case 1:
                headerCell.configure( viewModel: CellViewModel(configuration: .heading, isSelected: true))
            case 2:
                headerCell.configure(viewModel: CellViewModel(configuration: .subheading1, isSelected: true))
            case 3:
                headerCell.configure(viewModel: CellViewModel(configuration: .subheading2, isSelected: true))
            case 4:
                headerCell.configure(viewModel: CellViewModel(configuration: .subheading3, isSelected: true))
            case 5:
                headerCell.configure(viewModel: CellViewModel(configuration: .subheading4, isSelected: true))
            default:
                break
            }
            
        }
        return cell
    }
}

extension WKEditorInputHeaderSelectViewController: UITableViewDelegate {
    
}
