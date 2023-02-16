import Foundation
import UIKit
import UIComponents

class FeatureStartViewController: UIViewController, Themeable {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupInitialViews()
        addButtons()

        view.backgroundColor = .white
    }
    
    private func setupInitialViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: stackView.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFonts()
    }
    
    private func addButtons() {
        
        let feature1Button = UIButton(type: .system)
        feature1Button.titleLabel?.adjustsFontForContentSizeCategory = true
        feature1Button.setTitle("Feature 1 (UIKit)", for: .normal)
        feature1Button.addTarget(self, action: #selector(tappedFeature1), for: .touchUpInside)
        stackView.addArrangedSubview(feature1Button)
        
        let feature2Button = UIButton(type: .system)
        feature2Button.titleLabel?.adjustsFontForContentSizeCategory = true
        feature2Button.setTitle("Feature 2 (SwiftUI)", for: .normal)
        feature2Button.addTarget(self, action: #selector(tappedFeature2), for: .touchUpInside)
        stackView.addArrangedSubview(feature2Button)
        
        updateFonts()
    }
    
    @objc func tappedFeature1() {
        let viewModel = Feature1ViewModel(theme: theme)
        let vc = Feature1ViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tappedFeature2() {
//        let viewModel = Feature1ViewModel(theme: theme)
//        let vc = Feature1ViewController(viewModel: viewModel)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateFonts() {
        for subview in stackView.arrangedSubviews {
            if let button = subview as? UIButton {
                button.titleLabel?.font = UIFont.wmf_font(.georgiaTitle3, compatibleWithTraitCollection: traitCollection)
            }
        }
    }
    
    func apply(theme: Theme) {
        self.theme = theme
        view.backgroundColor = theme.colors.baseBackground
        
        for subview in stackView.arrangedSubviews {
            if let button = subview as? UIButton {
                button.tintColor = theme.colors.link
            }
        }
    }
}
