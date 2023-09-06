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

    private lazy var projectIconsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("Project Icons", for: .normal)
        button.addTarget(self, action: #selector(tappedIconsButton), for: .touchUpInside)
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
        stackView.addArrangedSubview(projectIconsButton)
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
        
        let viewModel = WKWatchlistViewModel(localizedStrings: WKWatchlistViewModel.LocalizedStrings(title: "Watchlist", filter: "Filter", byteChange: byteChange), presentationConfiguration: WKWatchlistViewModel.PresentationConfiguration())
        let filterViewModel = WKWatchlistFilterViewModel(localizedStrings: .demoStrings)
        let watchlistViewController = WKWatchlistViewController(viewModel: viewModel, filterViewModel: filterViewModel, delegate: nil)
		navigationController?.pushViewController(watchlistViewController, animated: true)
    }

    @objc private func tappedIconsButton() {
        let viewController = ProjectIconViewController()
        present(viewController, animated: true)
    }
}

extension ViewController: WKSourceEditorViewControllerDelegate {
    func sourceEditorViewControllerDidTapFind(sourceEditorViewController: WKSourceEditorViewController) {
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
