import Foundation
import UIKit

class WKEditorInputMainViewController: WKComponentViewController {
    
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
        label.text = strings.inputViewTextFormatting
        return label
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: WKIcon.close, style: .plain, target: self, action: #selector(close(_:)))
        return button
    }()
    
    private let plainReuseIdentifier = String(describing: WKEditorToolbarPlainCell.self)
    private let groupedReuseIdentifier = String(describing: WKEditorToolbarGroupedCell.self)
    private let detailReuseIdentifier = String(describing: WKEditorSelectionDetailCell.self)
    private let destructiveReuseIdentifier = String(describing: WKEditorDestructiveCell.self)
    
    weak var delegate: WKEditorInputViewDelegate?
    private let strings: WKEditorLocalizedStrings
    
    init(strings: WKEditorLocalizedStrings) {
        self.strings = strings
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        
        tableView.register(WKEditorToolbarPlainCell.self, forCellReuseIdentifier: plainReuseIdentifier)
        tableView.register(WKEditorToolbarGroupedCell.self, forCellReuseIdentifier: groupedReuseIdentifier)
        tableView.register(WKEditorSelectionDetailCell.self, forCellReuseIdentifier: detailReuseIdentifier)
        tableView.register(WKEditorDestructiveCell.self, forCellReuseIdentifier: destructiveReuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func close(_ sender: UIBarButtonItem) {
        delegate?.tappedClose()
    }
}

extension WKEditorInputMainViewController: UITableViewDataSource {
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
            
            if let detailCell = cell as? WKEditorSelectionDetailCell {
                // todo: smart selectionText
                detailCell.configure(viewModel: WKEditorSelectionDetailView.ViewModel(typeText: strings.inputViewStyle, selectionText: strings.inputViewParagraph))
            }
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: destructiveReuseIdentifier, for: indexPath)
            
            if let destructiveCell = cell as? WKEditorDestructiveCell {
                destructiveCell.configure(viewModel: WKEditorDestructiveView.ViewModel(text: strings.inputViewClearFormatting))
            }
        default:
            fatalError()
        }
        
        return cell
    }
}

extension WKEditorInputMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let headerVC = WKEditorInputHeaderSelectViewController(strings: strings)
            headerVC.delegate = delegate
            navigationController?.pushViewController(headerVC, animated: true)
        }
    }
}
