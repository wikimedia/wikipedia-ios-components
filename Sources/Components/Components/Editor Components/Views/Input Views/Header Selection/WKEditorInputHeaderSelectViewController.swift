import Foundation
import UIKit

class WKEditorInputHeaderSelectViewController: WKComponentViewController {
    
    typealias CellViewModel = WKEditorHeaderSelectCell.ViewModel
    
    enum Configuration {
        case leftTitleNav
        case standard
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = WKEditorLocalizedStrings.shared.inputViewStyle
        label.adjustsFontForContentSizeCategory = true
        label.font = WKFont.for(.headline, compatibleWith: appEnvironment.traitCollection)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    weak var delegate: WKEditorInputViewDelegate?
    private let configuration: Configuration
    
    private let reuseIdentifier = String(describing: WKEditorHeaderSelectCell.self)
    private let viewModels = [CellViewModel(configuration: .paragraph, isSelected: false),
                              CellViewModel(configuration: .heading, isSelected: false),
                              CellViewModel(configuration: .subheading1, isSelected: false),
                              CellViewModel(configuration: .subheading2, isSelected: false),
                              CellViewModel(configuration: .subheading3, isSelected: false),
                              CellViewModel(configuration: .subheading4, isSelected: false)]
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: WKIcon.close, style: .plain, target: self, action: #selector(close(_:)))
        return button
    }()
    
    init(configuration: Configuration, delegate: WKEditorInputViewDelegate?) {
        self.configuration = configuration
        self.delegate = delegate
        super.init()
        setupNavigationBar()
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
        
        //setupNavigationBar()
    }
    
    @objc private func close(_ sender: UIBarButtonItem) {
        delegate?.didTapClose()
    }
    
    private func setupNavigationBar() {
        switch configuration {
        case .standard:
            break
        case .leftTitleNav:
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        }
        navigationItem.rightBarButtonItem = closeButton
    }
}

extension WKEditorInputHeaderSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let headerCell = cell as? WKEditorHeaderSelectCell {
            let viewModel = viewModels[indexPath.row]
            switch indexPath.row {
            case 0:
                headerCell.configure(viewModel: viewModel)
            case 1:
                headerCell.configure( viewModel: viewModel)
            case 2:
                headerCell.configure(viewModel: viewModel)
            case 3:
                headerCell.configure(viewModel: viewModel)
            case 4:
                headerCell.configure(viewModel: viewModel)
            case 5:
                headerCell.configure(viewModel: viewModel)
            default:
                break
            }
            
        }
        return cell
    }
}

extension WKEditorInputHeaderSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for (index, viewModel) in viewModels.enumerated() {
            viewModel.isSelected = index == indexPath.row
        }
        tableView.reloadData()
    }
}
