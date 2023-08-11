import SwiftUI

struct WKWatchlistFilterView: View {

    let viewModel: WKWatchlistFilterViewModel

    var body: some View {
        NavigationView {
            Text("")
                .navigationTitle(viewModel.localizedStrings.title)
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}
