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
                    .frame(idealWidth: 20, idealHeight: 20, alignment: .center)
                    .background(Color.clear)
                    .font(WKFont.for(.caption1))
                    .foregroundColor(Color(appEnvironment.theme.secondaryText))
                    .padding(4)

            }
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(Color(appEnvironment.theme.secondaryText), lineWidth: 1)
            )

        case .wikidata:
            if let image = UIImage(named: "project-commons") {
                Image(uiImage: image)
                .frame(minWidth: 20, maxHeight: 20, alignment: .center)
                .foregroundColor(Color(appEnvironment.theme.secondaryText))
            }

        case .commons:
            if let image = UIImage(named: "project-wikidata") {
                Image(uiImage: image)
                .frame(minWidth: 20, maxHeight: 20, alignment: .center)
                .foregroundColor(Color(appEnvironment.theme.secondaryText))
            }
        }
    }
}
