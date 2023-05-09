import UIKit
import Components

struct ThemeButtonViewModel {
    let title: String
    let themeName: String
}

class SelectThemeViewController: WKCanvasViewController {

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
    
    private let viewModels = [
        ThemeButtonViewModel(title: "Default", themeName: "Default"),
        ThemeButtonViewModel(title: WKTheme.light.name, themeName: WKTheme.light.name),
        ThemeButtonViewModel(title: WKTheme.sepia.name, themeName: WKTheme.sepia.name),
        ThemeButtonViewModel(title: WKTheme.dark.name, themeName: WKTheme.dark.name),
        ThemeButtonViewModel(title: WKTheme.black.name, themeName: WKTheme.black.name),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupInitialViews()
        addThemeButtons()
    }
    
    private func setupInitialViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func addThemeButtons() {
        
        for (index, viewModel) in viewModels.enumerated() {
            let button = UIButton(type: .system)
            button.titleLabel?.adjustsFontForContentSizeCategory = true
            button.setTitle(viewModel.title, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        updateButtonSelectedStates()
    }
            
    @objc private func tappedButton(_ sender : UIButton) {
        let viewModel = viewModels[sender.tag]
        UserDefaults.standard.themeName = viewModel.themeName
        WKAppEnvironment.updateWithTraitCollection(traitCollection)
        updateButtonSelectedStates()
    }
    
    func updateButtonSelectedStates() {
        for (subview, theme) in zip(stackView.arrangedSubviews, viewModels) {
            if let button = subview as? UIButton {
                button.isSelected = theme.themeName == UserDefaults.standard.themeName
            }
        }
    }
}
