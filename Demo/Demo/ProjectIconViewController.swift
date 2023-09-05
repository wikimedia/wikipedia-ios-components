import SwiftUI
import UIKit
import Components
import WKData

final public class ProjectIconViewController: WKCanvasViewController {

   var hostingController: ProjectIconHostingViewController

    override init() {
       self.hostingController = ProjectIconHostingViewController()
       super.init()
   }

   required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    public override func viewDidLoad() {
       super.viewDidLoad()
           addComponent(hostingController, pinToEdges: true)
   }
}

final class ProjectIconHostingViewController: WKComponentHostingController<ProjectIconView>, UIAdaptivePresentationControllerDelegate {

   init() {
       super.init(rootView: ProjectIconView())

   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}

public struct ProjectIconView: View {

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    public var body: some View {
        ZStack {
            Color(appEnvironment.theme.paperBackground)
                .ignoresSafeArea()
            VStack {
                let project: WKProject = .wikidata
                let project2: WKProject = .commons
                
                let language3 = WKLanguage(languageCode: "es", languageVariantCode: nil)
                let project3: WKProject = .wikipedia(language3)
                let language4 = WKLanguage(languageCode: "pt", languageVariantCode: nil)
                let project4: WKProject = .wikipedia(language4)
                let language5 = WKLanguage(languageCode: "en", languageVariantCode: nil)
                let project5: WKProject = .wikipedia(language5)
                let language6 = WKLanguage(languageCode: "hant", languageVariantCode: "zh-Hant-HK")
                let project6: WKProject = .wikipedia(language6)
                let language7 = WKLanguage(languageCode: "hans", languageVariantCode: "zh-Hans")
                let project7: WKProject = .wikipedia(language7)
                
                WKProjectIconView(project: project)
                WKProjectIconView(project: project2)
                WKProjectIconView(project: project3)
                WKProjectIconView(project: project4)
                WKProjectIconView(project: project5)
                WKProjectIconView(project: project6)
                WKProjectIconView(project: project7)
            }
            .background(Color(appEnvironment.theme.paperBackground))
        }
    }
}
