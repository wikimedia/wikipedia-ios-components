import Foundation
import UIKit

class WKHeaderSelectionTableViewController: WKComponentViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    weak var delegate: WKEditorInputViewDelegate?
    
    private let reuseIdentifier = String(describing: WKSimpleSelectionTableViewCell.self)
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close(_:)))
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
        
        tableView.register(WKSimpleSelectionTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func close(_ sender: UIBarButtonItem) {
        delegate?.tappedClose()
    }
}

extension WKHeaderSelectionTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

extension WKHeaderSelectionTableViewController: UITableViewDelegate {
    
}
