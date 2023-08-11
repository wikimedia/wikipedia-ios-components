import SwiftUI

struct WKFormSelectSingleRowView: View {
    
    @ObservedObject var appEnvironment = WKAppEnvironment.current

    var theme: WKTheme {
        return appEnvironment.theme
    }
    
    @ObservedObject var viewModel: WKFormItemSelectViewModel
    
    var body: some View {
        Button(action: {
            // Don't allow toggling 'off'
            if !viewModel.isSelected {
                viewModel.isSelected = true
            }
        }) {
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .padding(6)
                        .foregroundColor(Color(theme.secondaryText))
                }
                Text(viewModel.title ?? "")
                    .foregroundColor(Color(theme.text))
                Spacer()
                if viewModel.isSelected {
                    WKCheckmarkView()
                }
            }
        }
    }
}
