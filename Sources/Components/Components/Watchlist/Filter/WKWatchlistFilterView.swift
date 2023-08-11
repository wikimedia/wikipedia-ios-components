import SwiftUI

struct WKWatchlistFilterView: View {

    let viewModel: WKWatchlistFilterViewModel

    var body: some View {
        NavigationView {
            WKFormView(viewModel: viewModel.formViewModel)
                .navigationTitle(viewModel.localizedStrings.title)
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}
