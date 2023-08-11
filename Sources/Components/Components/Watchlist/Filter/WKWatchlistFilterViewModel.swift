import Foundation
import WKData
import UIKit

public final class WKWatchlistFilterViewModel {
    
    // MARK: - Nested Types

    public struct LocalizedStrings {
        let title: String
        let localizedProjectNames: [WKProject: String]
        let wikimediaProjectsHeader: String
        let wikimediaProjectsFooter: String
        let wikipediasHeader: String
        let commonAll: String
        let latestRevisionsHeader: String
        let latestRevisionsLatestRevision: String
        let latestRevisionsNotLatestRevision: String
        let watchlistActivityHeader: String
        let watchlistActivityUnseenChanges: String
        let watchlistActivitySeenChanges: String
        let automatedContributionsHeader: String
        let automatedContributionsBot: String
        let automatedContributionsHuman: String
        let significanceHeader: String
        let significanceMinorEdits: String
        let significanceNonMinorEdits: String
        let userRegistrationHeader: String
        let userRegistrationUnregistered: String
        let userRegistrationRegistered: String
        let typeOfChangeHeader: String
        let typeOfChangePageEdits: String
        let typeOfChangePageCreations: String
        let typeOfChangeCategoryChanges: String
        let typeOfChangeWikidataEdits: String
        let typeOfChangeLoggedActions: String

        public init(title: String, localizedProjectNames: [WKProject : String], wikimediaProjectsHeader: String, wikimediaProjectsFooter: String, wikipediasHeader: String, commonAll: String, latestRevisionsHeader: String, latestRevisionsLatestRevision: String, latestRevisionsNotLatestRevision: String, watchlistActivityHeader: String, watchlistActivityUnseenChanges: String, watchlistActivitySeenChanges: String, automatedContributionsHeader: String, automatedContributionsBot: String, automatedContributionsHuman: String, significanceHeader: String, significanceMinorEdits: String, significanceNonMinorEdits: String, userRegistrationHeader: String, userRegistrationUnregistered: String, userRegistrationRegistered: String, typeOfChangeHeader: String, typeOfChangePageEdits: String, typeOfChangePageCreations: String, typeOfChangeCategoryChanges: String, typeOfChangeWikidataEdits: String, typeOfChangeLoggedActions: String) {
            self.title = title
            self.localizedProjectNames = localizedProjectNames
            self.wikimediaProjectsHeader = wikimediaProjectsHeader
            self.wikimediaProjectsFooter = wikimediaProjectsFooter
            self.wikipediasHeader = wikipediasHeader
            self.commonAll = commonAll
            self.latestRevisionsHeader = latestRevisionsHeader
            self.latestRevisionsLatestRevision = latestRevisionsLatestRevision
            self.latestRevisionsNotLatestRevision = latestRevisionsNotLatestRevision
            self.watchlistActivityHeader = watchlistActivityHeader
            self.watchlistActivityUnseenChanges = watchlistActivityUnseenChanges
            self.watchlistActivitySeenChanges = watchlistActivitySeenChanges
            self.automatedContributionsHeader = automatedContributionsHeader
            self.automatedContributionsBot = automatedContributionsBot
            self.automatedContributionsHuman = automatedContributionsHuman
            self.significanceHeader = significanceHeader
            self.significanceMinorEdits = significanceMinorEdits
            self.significanceNonMinorEdits = significanceNonMinorEdits
            self.userRegistrationHeader = userRegistrationHeader
            self.userRegistrationUnregistered = userRegistrationUnregistered
            self.userRegistrationRegistered = userRegistrationRegistered
            self.typeOfChangeHeader = typeOfChangeHeader
            self.typeOfChangePageEdits = typeOfChangePageEdits
            self.typeOfChangePageCreations = typeOfChangePageCreations
            self.typeOfChangeCategoryChanges = typeOfChangeCategoryChanges
            self.typeOfChangeWikidataEdits = typeOfChangeWikidataEdits
            self.typeOfChangeLoggedActions = typeOfChangeLoggedActions
        }
    }
    
    private struct WKProjectViewModel {
        let project: WKProject
        let projectName: String?
        let icon: UIImage?
        let isSelected: Bool
    }
    
    // MARK: - Properties
    
    let localizedStrings: LocalizedStrings
    private let projectViewModels: [WKProjectViewModel]
    let formViewModel: WKFormViewModel
    private let dataController = WKWatchlistDataController()
    
    // MARK: - Public
    
    public init(localizedStrings: LocalizedStrings) {
        self.localizedStrings = localizedStrings
        
        let filterSettings = dataController.loadFilterSettings()
        let allProjects = dataController.allWatchlistProjects()
        let offProjects = dataController.offWatchlistProjects()
        self.projectViewModels = Self.projectViewModels(allProjects: allProjects, offProjects: offProjects, strings: localizedStrings)
        
        let allChangeTypes = dataController.allChangeTypes()
        let offChangeTypes = dataController.offChangeTypes()
        
        self.formViewModel = WKFormViewModel(sections: [
            Self.section1(projectViewModels: Array(projectViewModels.prefix(2)), strings: localizedStrings),
            Self.section2(projectViewModels: Array(projectViewModels.suffix(from: 2)), strings: localizedStrings),
            Self.section3(strings: localizedStrings, filterSettings: filterSettings),
            Self.section4(strings: localizedStrings, filterSettings: filterSettings),
            Self.section5(strings: localizedStrings, filterSettings: filterSettings),
            Self.section6(strings: localizedStrings, filterSettings: filterSettings),
            Self.section7(strings: localizedStrings, filterSettings: filterSettings),
            Self.section8(allChangeTypes: allChangeTypes, offChangeTypes: offChangeTypes, strings: localizedStrings, filterSettings: filterSettings)
        ])
    }
    
    
}

// MARK: - Static Init Helper Methods

private extension WKWatchlistFilterViewModel {
    private static func projectViewModels(allProjects: [WKProject], offProjects: [WKProject], strings: WKWatchlistFilterViewModel.LocalizedStrings) -> [WKProjectViewModel] {

        var projectViewModels: [WKProjectViewModel] = []

        for project in allProjects {
            var icon: UIImage? = nil
            switch project {
            case .commons:
                icon = WKIcon.commons
            case .wikidata:
                icon = WKIcon.wikidata
            default:
                break
            }

            projectViewModels.append(WKProjectViewModel(project: project, projectName: strings.localizedProjectNames[project], icon: icon, isSelected: !offProjects.contains(project)))
        }

        return projectViewModels
    }
    
    private static func section1(projectViewModels: [WKProjectViewModel], strings: WKWatchlistFilterViewModel.LocalizedStrings) -> WKFormSectionSelectViewModel {

        let items = projectViewModels.map { projectViewModel in
            return WKFormItemSelectViewModel(image: projectViewModel.icon, title: projectViewModel.projectName, isSelected: projectViewModel.isSelected)

        }

        return WKFormSectionSelectViewModel(header: strings.wikimediaProjectsHeader, footer: strings.wikimediaProjectsFooter, items: items, selectType: .multi)
    }

    private static func section2(projectViewModels: [WKProjectViewModel], strings: WKWatchlistFilterViewModel.LocalizedStrings) -> WKFormSectionSelectViewModel {

        let items = projectViewModels.map { projectViewModel in
            return WKFormItemSelectViewModel(image: projectViewModel.icon, title: projectViewModel.projectName, isSelected: projectViewModel.isSelected)
        }

        return WKFormSectionSelectViewModel(header: strings.wikipediasHeader, items: items, selectType: .multi)
    }

    private static func section3(strings: WKWatchlistFilterViewModel.LocalizedStrings, filterSettings: WKWatchlistFilterSettings) -> WKFormSectionSelectViewModel {
        let items = [
            WKFormItemSelectViewModel(title: strings.commonAll, isSelected: filterSettings.latestRevisions == .all),
            WKFormItemSelectViewModel(title: strings.latestRevisionsLatestRevision, isSelected: filterSettings.latestRevisions == .latestRevision),
            WKFormItemSelectViewModel(title: strings.latestRevisionsNotLatestRevision, isSelected: filterSettings.latestRevisions == .notTheLatestRevision)
        ]
        return WKFormSectionSelectViewModel(header: strings.latestRevisionsHeader, items: items, selectType: .single)
    }

    private static func section4(strings: WKWatchlistFilterViewModel.LocalizedStrings, filterSettings: WKWatchlistFilterSettings) -> WKFormSectionSelectViewModel {
        let items = [
            WKFormItemSelectViewModel(title: strings.commonAll, isSelected: filterSettings.activity == .all),
            WKFormItemSelectViewModel(title: strings.watchlistActivityUnseenChanges, isSelected: filterSettings.activity == .unseenChanges),
            WKFormItemSelectViewModel(title: strings.watchlistActivitySeenChanges, isSelected: filterSettings.activity == .seenChanges)
        ]
        return WKFormSectionSelectViewModel(header: strings.watchlistActivityHeader, items: items, selectType: .single)
    }

    private static func section5(strings: WKWatchlistFilterViewModel.LocalizedStrings, filterSettings: WKWatchlistFilterSettings) -> WKFormSectionSelectViewModel {
        let items = [
            WKFormItemSelectViewModel(title: strings.commonAll, isSelected: filterSettings.automatedContributions == .all),
            WKFormItemSelectViewModel(title: strings.automatedContributionsBot, isSelected: filterSettings.automatedContributions == .bot),
            WKFormItemSelectViewModel(title: strings.automatedContributionsHuman, isSelected: filterSettings.automatedContributions == .human)
        ]
        return WKFormSectionSelectViewModel(header: strings.automatedContributionsHeader, items: items, selectType: .single)
    }

    private static func section6(strings: WKWatchlistFilterViewModel.LocalizedStrings, filterSettings: WKWatchlistFilterSettings) -> WKFormSectionSelectViewModel {
        let items = [
            WKFormItemSelectViewModel(title: strings.commonAll, isSelected: filterSettings.significance == .all),
            WKFormItemSelectViewModel(title: strings.significanceMinorEdits, isSelected: filterSettings.significance == .minorEdits),
            WKFormItemSelectViewModel(title: strings.significanceNonMinorEdits, isSelected: filterSettings.significance == .nonMinorEdits)
        ]
        return WKFormSectionSelectViewModel(header: strings.significanceHeader, items: items, selectType: .single)
    }

    private static func section7(strings: WKWatchlistFilterViewModel.LocalizedStrings, filterSettings: WKWatchlistFilterSettings) -> WKFormSectionSelectViewModel {
        let items = [
            WKFormItemSelectViewModel(title: strings.commonAll, isSelected: filterSettings.userRegistration == .all),
            WKFormItemSelectViewModel(title: strings.userRegistrationUnregistered, isSelected: filterSettings.userRegistration == .unregistered),
            WKFormItemSelectViewModel(title: strings.userRegistrationRegistered, isSelected: filterSettings.userRegistration == .registered)
        ]
        return WKFormSectionSelectViewModel(header: strings.userRegistrationHeader, items: items, selectType: .single)
    }

    private static func section8(allChangeTypes: [WKWatchlistFilterSettings.ChangeType], offChangeTypes: [WKWatchlistFilterSettings.ChangeType], strings: WKWatchlistFilterViewModel.LocalizedStrings, filterSettings: WKWatchlistFilterSettings) -> WKFormSectionViewModel {

        var items: [WKFormItemSelectViewModel] = []
        for changeType in allChangeTypes {
            
            var title: String
            
            switch changeType {
            case .categoryChanges:
                title = strings.typeOfChangeCategoryChanges
            case .loggedActions:
                title = strings.typeOfChangeLoggedActions
            case .pageCreations:
                title = strings.typeOfChangePageCreations
            case .pageEdits:
                title = strings.typeOfChangePageEdits
            case .wikidataEdits:
                title = strings.typeOfChangeWikidataEdits
            }
            
            items.append(WKFormItemSelectViewModel(title: title, isSelected: !offChangeTypes.contains(changeType)))
        }

        return WKFormSectionSelectViewModel(header: strings.typeOfChangeHeader, items: items, selectType: .multi)
    }
}
