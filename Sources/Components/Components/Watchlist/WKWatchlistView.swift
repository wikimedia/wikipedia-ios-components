import SwiftUI

struct WKWatchlistView: View {

	// MARK: - Properties

	@ObservedObject var appEnvironment = WKAppEnvironment.current
	let viewModel: WKWatchlistViewModel
	weak var delegate: WKWatchlistDelegate?

	// MARK: - Lifecycle

	var body: some View {
		ZStack {
			Color(appEnvironment.theme.paperBackground)
				.ignoresSafeArea()
			List {
				WKWatchlistViewCell()
			}
			.listStyle(.plain)
        }
        .onAppear {
            viewModel.fetchWatchlist()
        }
	}

}

struct WKWatchlistViewCell: View {

	var body: some View {
		VStack {
			Text("Watchlist")
		}
	}

}

