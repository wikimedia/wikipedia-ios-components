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
    
    private let strings: WKEditorLocalizedStrings
    private let reuseIdentifier = String(describing: WKEditorHeaderSelectCell.self)
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: WKIcon.close, style: .plain, target: self, action: #selector(close(_:)))
        return button
    }()
    
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
        
        tableView.register(WKEditorHeaderSelectCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func close(_ sender: UIBarButtonItem) {
        delegate?.tappedClose()
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
                headerCell.configure(viewModel: CellViewModel(configuration: .paragraph, isSelected: true), strings: strings)
            case 1:
                headerCell.configure( viewModel: CellViewModel(configuration: .heading, isSelected: true), strings: strings)
            case 2:
                headerCell.configure(viewModel: CellViewModel(configuration: .subheading1, isSelected: true), strings: strings)
            case 3:
                headerCell.configure(viewModel: CellViewModel(configuration: .subheading2, isSelected: true), strings: strings)
            case 4:
                headerCell.configure(viewModel: CellViewModel(configuration: .subheading3, isSelected: true), strings: strings)
            case 5:
                headerCell.configure(viewModel: CellViewModel(configuration: .subheading4, isSelected: true), strings: strings)
            default:
                break
            }
            
        }
        return cell
    }
}

extension WKEditorInputHeaderSelectViewController: UITableViewDelegate {
    
}
