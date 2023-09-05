import UIKit
import Components
import WKData
import WKDataMocks

class ViewController: WKCanvasViewController {
	
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
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
    
    private lazy var selectThemeButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Select Theme", for: .normal)
        button.addTarget(self, action: #selector(tappedSelectTheme), for: .touchUpInside)
        return button
    }()
    
    private lazy var sourceEditorButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Source Editor", for: .normal)
        button.addTarget(self, action: #selector(tappedSourceEditor), for: .touchUpInside)
        return button
    }()

	private lazy var menuButtonButton: UIButton = {
		let button = UIButton(type: .system)
		button.titleLabel?.adjustsFontForContentSizeCategory = true
		button.setTitle("Menu Button", for: .normal)
		button.addTarget(self, action: #selector(tappedMenuButton), for: .touchUpInside)
		return button
	}()

    
    private lazy var watchlistButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Watchlist", for: .normal)
        button.addTarget(self, action: #selector(tappedWatchlist), for: .touchUpInside)
        return button
    }()

    private lazy var onboardingButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Onboarding", for: .normal)
        button.addTarget(self, action: #selector(tappedOboarding), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Components"

        setupInitialViews()
        
        stackView.addArrangedSubview(selectThemeButton)
        stackView.addArrangedSubview(sourceEditorButton)
		stackView.addArrangedSubview(menuButtonButton)
        stackView.addArrangedSubview(watchlistButton)
        stackView.addArrangedSubview(onboardingButton)
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
    
    @objc private func tappedSelectTheme() {
        let viewController = SelectThemeViewController()
        present(viewController, animated: true)
    }
    
    @objc private func tappedSourceEditor() {
        let viewModel = WKSourceEditorViewModel(configuration: .full, initialText: "")
        let viewController = WKSourceEditorViewController(viewModel: viewModel, delegate: self)
        present(viewController, animated: true)
    }

    @objc private func tappedMenuButton() {
        let viewController = MenuButtonViewController()
        present(viewController, animated: true)
    }
    
    @objc private func tappedWatchlist() {
        let mockService = WKMockWatchlistMediaWikiNetworkService()
        mockService.randomizeGetWatchStatusResponse = true
        
        WKDataEnvironment.current.mediaWikiNetworkService = mockService
        WKDataEnvironment.current.appData = WKAppData(appLanguages: [
            WKLanguage(languageCode: "en", languageVariantCode: nil),
            WKLanguage(languageCode: "es", languageVariantCode: nil)
        ])

        let byteChange: (Int) -> String = { bytes in
			return bytes == 0 || bytes > 1 || bytes < -1
                ? "\(bytes) bytes"
                : "\(bytes) byte"
        }

		let viewModel = WKWatchlistViewModel(localizedStrings: WKWatchlistViewModel.LocalizedStrings(title: "Watchlist", filter: "Filter", byteChange: byteChange), presentationConfiguration: WKWatchlistViewModel.PresentationConfiguration())
		let watchlistViewController = WKWatchlistViewController(viewModel: viewModel, delegate: nil)
		navigationController?.pushViewController(watchlistViewController, animated: true)
    }

    @objc private func tappedOboarding() {
        let cell1Image = WKSFSymbolIcon.for(symbol: .star, font: .body)
        let cell1 = WKOnboardingViewModel.WKOnboardingCellViewModel(icon: cell1Image, title: "Short title", subtitle: "The Watchlist is a tool that lets you keep track of changes made to pages or articles you're interested in")
        
        let cell2Image = WKSFSymbolIcon.for(symbol: .person, font: .body)
        let cell2 = WKOnboardingViewModel.WKOnboardingCellViewModel(icon: cell2Image, title: "Short title", subtitle: "The Watchlist is a tool that lets you keep track of changes made to pages or articles you're interested in")
        
        let cell3Image = WKSFSymbolIcon.for(symbol: .starLeadingHalfFilled, font: .body)
        let cell3 = WKOnboardingViewModel.WKOnboardingCellViewModel(icon: cell3Image, title: "Short title", subtitle: "The Watchlist is a tool that lets you keep track of changes made to pages or articles you're interested in The Watchlist is a tool that lets you keep track of changes made to pages or articles you're interested in")
        
        let cell4Image = WKSFSymbolIcon.for(symbol: .heart, font: .body)
        let cell4 = WKOnboardingViewModel.WKOnboardingCellViewModel(icon: cell4Image, title: "Very long title that continues for a while", subtitle: "Small text")
        
        let cell5 = WKOnboardingViewModel.WKOnboardingCellViewModel(icon: nil, title: "Title title", subtitle: "Small text")
        let viewModel = WKOnboardingViewModel(title: "Onboarding Modal Component", cells: [cell1, cell2, cell3, cell4, cell5], primaryButtonTitle: "Primary button", secondaryButtonTitle: "Secondary button")

        let viewController = WKOnboardingViewController(viewModel: viewModel)
        viewController.hostingController.delegate = self

        present(viewController, animated: true)
    }
}

extension ViewController: WKSourceEditorViewControllerDelegate {
    func sourceEditorViewControllerDidTapFind(sourceEditorViewController: WKSourceEditorViewController) {
    }
}

extension ViewController: WKOnboardingViewDelegate {
    func didClickPrimaryButton() {
        let alert = UIAlertController(title: "Hello", message: "Pressed primary button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        if let presentedViewController {
            presentedViewController.present(alert, animated: true)
        }
    }

    func didClickSecondaryButton() {
        let alert = UIAlertController(title: "Hi", message: "Pressed secondary button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        if let presentedViewController {
            presentedViewController.present(alert, animated: true)
        }
    }
}
