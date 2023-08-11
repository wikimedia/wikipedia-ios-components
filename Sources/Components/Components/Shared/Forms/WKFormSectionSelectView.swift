import SwiftUI

struct WKFormSectionSelectView: View {
    @ObservedObject var appEnvironment = WKAppEnvironment.current

    var theme: WKTheme {
        return appEnvironment.theme
    }

    let viewModel: WKFormSectionSelectViewModel

    var body: some View {
        Section(header: Text(viewModel.header ?? ""), footer: Text(viewModel.footer ?? "")) {
            ForEach(viewModel.items) { item in
                switch viewModel.selectType {
                case .multi:
                    WKFormSelectMultiRowView(viewModel: item)
                case .single:
                    WKFormSelectSingleRowView(viewModel: item)
                }
            }
        }
    }
}
