import UIKit
import UIComponents

struct ThemeButtonViewModel {
    let title: String
    let themeID: String
}

class SettingsViewController: UIViewController, Themeable {

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
        ThemeButtonViewModel(title: CommonStrings.defaultThemeDisplayName, themeID: Theme.defaultThemeName),
        ThemeButtonViewModel(title: Theme.light.displayName, themeID: Theme.light.name),
        ThemeButtonViewModel(title: Theme.sepia.displayName, themeID: Theme.sepia.name),
        ThemeButtonViewModel(title: Theme.dark.displayName, themeID: Theme.dark.name),
        ThemeButtonViewModel(title: Theme.black.displayName, themeID: Theme.black.name)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupInitialViews()
        addThemeButtons()

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
    
    private func addThemeButtons() {
        
        for (index, viewModel) in viewModels.enumerated() {
            let button = UIButton(type: .system)
            button.titleLabel?.adjustsFontForContentSizeCategory = true
            button.setTitle(viewModel.title, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        updateFonts()
        updateButtonSelectedStates()
    }
            
    @objc private func tappedButton(_ sender : UIButton) {
        let viewModel = viewModels[sender.tag]
        let userInfo: [String: Any] = [NSNotification.UserInfoKeys.WMFUserDidSelectThemeNotificationThemeNameKey: viewModel.themeID]
        NotificationCenter.default.post(name: Notification.Name.WMFUserDidSelectThemeNotification, object: nil, userInfo: userInfo)
        updateButtonSelectedStates()
    }
    
    func updateButtonSelectedStates() {
        let currentAppTheme = UserDefaults.standard.themeName
        
        for (subview, theme) in zip(stackView.arrangedSubviews, viewModels) {
            if let button = subview as? UIButton {
                button.isSelected = theme.themeID == currentAppTheme
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFonts()
    }
    
    func updateFonts() {
        for subview in stackView.arrangedSubviews {
            if let button = subview as? UIButton {
                button.titleLabel?.font = UIFont.wmf_font(.italicBody, compatibleWithTraitCollection: traitCollection)
            }
        }
    }
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.colors.baseBackground
        
        for subview in stackView.arrangedSubviews {
            if let button = subview as? UIButton {
                button.tintColor = theme.colors.link
            }
        }
    }
}

