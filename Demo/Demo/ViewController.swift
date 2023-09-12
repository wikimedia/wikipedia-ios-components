import UIKit
import SwiftUI
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
    
    private lazy var projectIconsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Project Icons", for: .normal)
        button.addTarget(self, action: #selector(tappedIconsButton), for: .touchUpInside)
        return button
    }()

    private lazy var emptyViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Empty View", for: .normal)
        button.addTarget(self, action: #selector(tappedEmptyViewRegularButton), for: .touchUpInside)
        return button
    }()

    private lazy var emptyViewFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Empty View - Filter option", for: .normal)
        button.addTarget(self, action: #selector(tappedEmptyViewFilterButton), for: .touchUpInside)
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
        stackView.addArrangedSubview(projectIconsButton)
        stackView.addArrangedSubview(emptyViewButton)
        stackView.addArrangedSubview(emptyViewFilterButton)
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
		let actionSheet = UIAlertController(title: "Select UI Framework", message: nil, preferredStyle: .actionSheet)
		actionSheet.addAction(UIAlertAction(title: "SwiftUI", style: .default, handler: { _ in
			let canvas = WKCanvasViewController()
			canvas.addComponent(WKComponentHostingController(rootView: SwiftUIMenuButtonView()), pinToEdges: true)
			self.present(canvas, animated: true)
		}))
		actionSheet.addAction(UIAlertAction(title: "UIKit", style: .default, handler: { _ in
			let viewController = MenuButtonViewController()
			self.present(viewController, animated: true)
		}))
		actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		present(actionSheet, animated: true)
	}

    @objc private func tappedWatchlist() {
        let mockService = WKMockWatchlistMediaWikiService()
        mockService.randomizeGetWatchStatusResponse = true
        
        WKDataEnvironment.current.mediaWikiService = mockService
        WKDataEnvironment.current.appData = WKAppData(appLanguages: [
            WKLanguage(languageCode: "en", languageVariantCode: nil),
            WKLanguage(languageCode: "es", languageVariantCode: nil)
        ])

        let byteChange: (Int) -> String = { bytes in
            return bytes == 0 || bytes > 1 || bytes < -1
                ? "\(bytes) bytes"
                : "\(bytes) byte"
        }

        let filters: (Int) -> AttributedString = { filters in
            return filters == 1
                ? AttributedString("You have \(filters) filter")
                : AttributedString("You have \(filters) filters")
        }

        let localizedStrings = WKWatchlistViewModel.LocalizedStrings(title: "Watchlist", filter: "Filter", userButtonUserPage: "User", userButtonTalkPage: "User Talk", userButtonContributions: "Contributions", userButtonThank: "Thank", byteChange: byteChange
        )
        let viewModel = WKWatchlistViewModel(localizedStrings: localizedStrings, presentationConfiguration: WKWatchlistViewModel.PresentationConfiguration())

        let emptyViewLocalizedStrings = WKEmptyViewModel.LocalizedStrings(title: "Title", subtitle: "subtitle subtitle subtitle", titleFilter: "Title", buttonTitle: "Button title", attributedFilterString: filters)

        let emptyViewModel = WKEmptyViewModel(localizedStrings: emptyViewLocalizedStrings, image: UIImage(named: "watchlist-empty-state") ?? UIImage(), numberOfFilters: viewModel.activeFilterCount)

        let filterViewModel = WKWatchlistFilterViewModel(localizedStrings: .demoStrings)

        let watchlistViewController = WKWatchlistViewController(viewModel: viewModel, filterViewModel: filterViewModel, emptyViewModel: emptyViewModel, delegate: self)

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

    @objc private func tappedIconsButton() {
        let viewController = ProjectIconViewController()
        present(viewController, animated: true)
    }

    @objc func tappedEmptyViewRegularButton() {
        let filters: (Int) -> AttributedString = { filters in
            return filters == 1
                ? AttributedString("You have \(filters) filters")
                : AttributedString("You have \(filters) filter")
        }

        let emptyViewLocalizedStrings = WKEmptyViewModel.LocalizedStrings(title: "Title", subtitle: "subtitle subtitle subtitle", titleFilter: "Title", buttonTitle: "Button title", attributedFilterString: filters)

        let emptyViewModel = WKEmptyViewModel(localizedStrings: emptyViewLocalizedStrings, image: UIImage(named: "watchlist-empty-state") ?? UIImage(), numberOfFilters: 3)

        let viewController = WKEmptyViewController(viewModel: emptyViewModel, type: .noItems, delegate: self)
        present(viewController, animated: true)
    }

    @objc func tappedEmptyViewFilterButton() {
        let filters: (Int) -> AttributedString = { filters in
            return filters == 1
                ? AttributedString("You have \(filters) filter")
                : AttributedString("You have \(filters) filters")
        }

        let emptyViewLocalizedStrings = WKEmptyViewModel.LocalizedStrings(title: "Title", subtitle: "subtitle subtitle subtitle", titleFilter: "Title", buttonTitle: "Button title", attributedFilterString: filters)

        let emptyViewModel = WKEmptyViewModel(localizedStrings: emptyViewLocalizedStrings, image: UIImage(named: "watchlist-empty-state") ?? UIImage(), numberOfFilters: 3)

        let viewController = WKEmptyViewController(viewModel: emptyViewModel, type: .filter, delegate: self)
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

private extension WKWatchlistFilterViewModel.LocalizedStrings {
    static var demoStrings: WKWatchlistFilterViewModel.LocalizedStrings {
        let localizedProjectNames: [WKProject: String] = [
                    WKProject.commons: "Wikimedia Commons",
                    WKProject.wikidata: "Wikidata",
                    WKProject.wikipedia(WKLanguage(languageCode: "en", languageVariantCode: nil)): "English Wikipedia",
                    WKProject.wikipedia(WKLanguage(languageCode: "es", languageVariantCode: nil)): "Spanish Wikipedia"
                ]
        return WKWatchlistFilterViewModel.LocalizedStrings(title: "Filter",
                                        doneTitle: "Done",
                                        localizedProjectNames: localizedProjectNames,
                                        wikimediaProjectsHeader: "Wikimedia Projects",
                                        wikipediasHeader: "Wikipedias",
                                        commonAll: "All",
                                        latestRevisionsHeader: "Latest Revisions",
                                        latestRevisionsLatestRevision: "Latest revision",
                                        latestRevisionsNotLatestRevision: "Not the latest revision",
                                        watchlistActivityHeader: "Watchlist Activity",
                                        watchlistActivityUnseenChanges: "Unseen changes",
                                        watchlistActivitySeenChanges: "Seen changes",
                                        automatedContributionsHeader: "Automated Contributions",
                                        automatedContributionsBot: "Bot",
                                        automatedContributionsHuman: "Human (not bot)",
                                        significanceHeader: "Significance",
                                        significanceMinorEdits: "Minor edits",
                                        significanceNonMinorEdits: "Non-minor edits",
                                        userRegistrationHeader: "User registration and experience",
                                        userRegistrationUnregistered: "Unregistered",
                                        userRegistrationRegistered: "Registered",
                                        typeOfChangeHeader: "Type of change",
                                        typeOfChangePageEdits: "Page edits",
                                        typeOfChangePageCreations: "Page creations",
                                        typeOfChangeCategoryChanges: "Category changes",
                                        typeOfChangeWikidataEdits: "Wikidata edits",
                                        typeOfChangeLoggedActions: "Logged actions")
    }
}

extension ViewController: WKEmptyViewDelegate {
    func didTapSearch() {
        let alert = UIAlertController(title: "Hello", message: "Pressed button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        if let presentedViewController {
            presentedViewController.present(alert, animated: true)
        }
    }

    func didTapFilters() {
        let alert = UIAlertController(title: "Hello", message: "Pressed filter button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        if let presentedViewController {
            presentedViewController.present(alert, animated: true)
        }
    }

}

extension ViewController: WKWatchlistDelegate {

    func watchlistDidDismiss() {
        print("Watchlist: did dismiss")
    }

    public func emptyViewDidTapSearch() {
        print("Empty view: did tap search")
    }

    func watchlistUserDidTapUser(username: String, action: Components.WKWatchlistUserButtonAction) {
        print("Watchlist: user did tap \(username) → \(action)")
    }

	func watchlistUserDidTapDiff(project: WKProject, title: String, revisionID: UInt, oldRevisionID: UInt) {
			print("Watchlist: user did tap diff \(project) → \(title) → \(revisionID) → \(oldRevisionID)")
		}
}

extension ViewController: WKMenuButtonDelegate {

    func wkSwiftUIMenuButtonUserDidTap(configuration: WKMenuButton.Configuration, item: WKMenuButton.MenuItem?) {
        print("WKMenuButton: user tapped \(String(describing: configuration.title)) → \(String(describing: item?.title))")
    }
}
