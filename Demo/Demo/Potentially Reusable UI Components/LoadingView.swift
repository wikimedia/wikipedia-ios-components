import Foundation
import UIKit

class LoadingView: UIView {
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isHidden = true
        addSubview(spinner)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
            centerYAnchor.constraint(equalTo: spinner.centerYAnchor)
        ])
    }
    
    func start() {
        spinner.startAnimating()
        isHidden = false
    }
    
    func stop() {
        spinner.stopAnimating()
        isHidden = true
    }
}
