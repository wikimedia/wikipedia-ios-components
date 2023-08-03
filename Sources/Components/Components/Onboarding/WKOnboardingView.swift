import SwiftUI

struct WKOnboardingView: View {

    // MARK: - Properties

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    // MARK: - Lifecycle

    var body: some View {
        ZStack {
            Color(appEnvironment.theme.paperBackground)
                .ignoresSafeArea()
            List {
                TempCell()
            }
            .listStyle(.plain)
        }
    }
}

struct TempCell: View {

    var body: some View {
            VStack {
                Text("Test")
            }
        }
}
