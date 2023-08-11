import Foundation
import WKData

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
    
    let localizedStrings: LocalizedStrings
    var formViewModel: WKFormViewModel
    
    public init(localizedStrings: LocalizedStrings) {
        self.localizedStrings = localizedStrings

        self.formViewModel = WKFormViewModel(sections: [])
    }
}
