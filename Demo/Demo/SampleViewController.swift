import SwiftUI
import UIKit
import Components
import WKData

final public class SampleViewController: WKCanvasViewController {

   var hostingController: SampleSwiftUIHostingViewController

    override init() {
       self.hostingController = SampleSwiftUIHostingViewController()
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

final class SampleSwiftUIHostingViewController: WKComponentHostingController<SampleView>, UIAdaptivePresentationControllerDelegate {

   init() {
       super.init(rootView: SampleView())

   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}

public struct SampleView: View {

   public var body: some View {
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
   }
}
