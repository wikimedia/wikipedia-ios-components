import Foundation
import UIKit

class FeatureView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var dataView: DataView = {
        let dataView = DataView()
        dataView.translatesAutoresizingMaskIntoConstraints = false
        return dataView
    }()
    
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true
        return errorView
    }()
    
    private lazy var emptyView: EmptyView = {
        let emptyView = EmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isHidden = true
        return emptyView
    }()
    
    private func setup() {
        addSubview(dataView)
        addSubview(errorView)
        addSubview(emptyView)
        NSLayoutConstraint.activate([
            safeAreaLayoutGuide.topAnchor.constraint(equalTo: dataView.topAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: dataView.bottomAnchor),
            safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: dataView.leadingAnchor),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: dataView.trailingAnchor),
            safeAreaLayoutGuide.topAnchor.constraint(equalTo: errorView.topAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: errorView.bottomAnchor),
            safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: errorView.leadingAnchor),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: errorView.trailingAnchor),
            safeAreaLayoutGuide.topAnchor.constraint(equalTo: emptyView.topAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor),
            safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor)
        ])
    }
    
    func updateEmptyView(isVisible: Bool) {
        emptyView.isHidden = !isVisible
    }
    
    func updateErrorView(isVisible: Bool) {
        errorView.isHidden = !isVisible
    }
}
