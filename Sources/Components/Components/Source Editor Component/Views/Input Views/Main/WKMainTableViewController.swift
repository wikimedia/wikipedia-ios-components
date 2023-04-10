import Foundation
import UIKit

class WKMainTableViewController: WKComponentViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text formatting"
        return label
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close(_:)))
        return button
    }()
    
    private let plainReuseIdentifier = String(describing: WKPlainToolbarTableViewCell.self)
    private let groupedReuseIdentifier = String(describing: WKGroupedToolbarTableViewCell.self)
    private let detailReuseIdentifier = String(describing: WKDetailTableViewCell.self)
    private let destructiveReuseIdentifier = String(describing: WKDestructiveTableViewCell.self)
    
    weak var delegate: WKEditorInputViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        
        tableView.register(WKPlainToolbarTableViewCell.self, forCellReuseIdentifier: plainReuseIdentifier)
        tableView.register(WKGroupedToolbarTableViewCell.self, forCellReuseIdentifier: groupedReuseIdentifier)
        tableView.register(WKDetailTableViewCell.self, forCellReuseIdentifier: detailReuseIdentifier)
        tableView.register(WKDestructiveTableViewCell.self, forCellReuseIdentifier: destructiveReuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func close(_ sender: UIBarButtonItem) {
        delegate?.tappedClose()
    }
}

extension WKMainTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: plainReuseIdentifier, for: indexPath)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: groupedReuseIdentifier, for: indexPath)
        case 2:
            
            cell = tableView.dequeueReusableCell(withIdentifier: detailReuseIdentifier, for: indexPath)
            
            if let detailCell = cell as? WKDetailTableViewCell {
                detailCell.configure(configuration: WKDetailButtonView.Configuration(typeText: "Style", selectionText: "Paragraph"))
            }
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: destructiveReuseIdentifier, for: indexPath)
            
            if let destructiveCell = cell as? WKDestructiveTableViewCell {
                destructiveCell.configure(configuration: WKDestructiveButtonView.Configuration(text: "Clear Formatting"))
            }
        default:
            fatalError()
        }
        
        return cell
    }
}

extension WKMainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let headerVC = WKHeaderSelectionTableViewController()
            headerVC.delegate = delegate
            navigationController?.pushViewController(headerVC, animated: true)
        }
    }
}
