
import Foundation
import UIKit

class WKDestructiveTableViewCell: UITableViewCell {
    
    private lazy var componentView: WKDestructiveButtonView = {
       let view = WKDestructiveButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(componentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: componentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: componentView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: componentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: componentView.bottomAnchor)
        ])
    }
    
    func configure(configuration: WKDestructiveButtonView.Configuration) {
        componentView.configure(configuration: configuration)
    }
}
