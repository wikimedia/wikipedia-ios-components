import SwiftUI
import WKData

public struct WKProjectIconView: View {

    public var project: WKProject

    public init(project: WKProject) {
        self.project = project
    }

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    public var body: some View {
        switch project {
        case .wikipedia(let wKLanguage):
            let capitalizedText = wKLanguage.languageCode.uppercased()
            HStack {
                Text(capitalizedText)
                    .background(Color(appEnvironment.theme.paperBackground))
                    .font(WKFont.for(.caption1))
                    .foregroundColor(Color(appEnvironment.theme.secondaryText))
                    .padding([.leading, .trailing], 3)
                    .padding([.top, .bottom], 4)

            }
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(Color(appEnvironment.theme.secondaryText), lineWidth: 1)
            )

        case .wikidata:
            if let image = UIImage(named: "project-commons", in: Bundle.module, compatibleWith: nil) {
                Image(uiImage: image)
                    .scaledToFit()
                    .background(Color(appEnvironment.theme.paperBackground))
                    .foregroundColor(Color(appEnvironment.theme.secondaryText))
                    .padding(6)
            }

        case .commons:
            if let image = UIImage(named: "project-wikidata", in: Bundle.module, compatibleWith: nil) {
                Image(uiImage: image)
                    .scaledToFit()
                    .background(Color(appEnvironment.theme.paperBackground))
                    .foregroundColor(Color(appEnvironment.theme.secondaryText))
                    .padding(6)
            }
        }
    }
}
