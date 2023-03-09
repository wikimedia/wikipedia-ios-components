import Foundation
import UIKit
import Components

class Feature1View: UIView, Themeable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var dataView: Data1View = {
        let dataView = Data1View()
        dataView.translatesAutoresizingMaskIntoConstraints = false
        return dataView
    }()
    
    private lazy var errorView: Error1View = {
        let errorView = Error1View()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true
        return errorView
    }()
    
    private lazy var emptyView: Empty1View = {
        let emptyView = Empty1View()
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
    
    func apply(theme: Theme) {
        backgroundColor = theme.colors.baseBackground
        dataView.apply(theme: theme)
        emptyView.apply(theme: theme)
        errorView.apply(theme: theme)
    }
}
