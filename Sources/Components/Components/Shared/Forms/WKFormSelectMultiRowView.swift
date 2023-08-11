import SwiftUI

struct WKFormSelectMultiRowView: View {

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    var theme: WKTheme {
        return appEnvironment.theme
    }

    @ObservedObject var viewModel: WKFormItemSelectViewModel

    var body: some View {
        HStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .padding(6)
                    .foregroundColor(Color(theme.secondaryText))
            }
            WKToggleView(title: viewModel.title ?? "", isSelected: $viewModel.isSelected)
        }
    }
}
