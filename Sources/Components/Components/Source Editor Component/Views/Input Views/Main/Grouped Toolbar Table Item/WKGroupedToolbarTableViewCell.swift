
import Foundation
import UIKit

class WKGroupedToolbarTableViewCell: UITableViewCell {
    
    lazy var componentView: UIView = {
        let view = UINib(nibName: String(describing: WKGroupedToolbarView.self), bundle: Bundle.module).instantiate(withOwner: nil).first as! UIView
        
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
}
