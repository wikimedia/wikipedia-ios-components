import SwiftUI

struct WKOnboardingView: View {

    // MARK: - Properties

    var viewModel: WKOnboardingViewModel

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    // MARK: - Lifecycle

    var body: some View {
        Group {
            ScrollView {
                VStack {
                    Color(appEnvironment.theme.paperBackground)
                        .ignoresSafeArea()
                    Text(viewModel.title)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    ForEach (1...viewModel.cells.count, id:\.self) { cell in
                        VStack {
                            WKOnboardingCell(viewModel: viewModel.cells[cell - 1])
                                .padding(20)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct WKOnboardingCell: View {

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    var viewModel: WKOnboardingViewModel.WKOnboardingCellViewModel

    var body: some View {
            HStack {
                if let icon = viewModel.icon {
                    Image(systemName: icon)
                        .frame(width: 24, alignment: .top)
                    .accessibilityHidden(true)
                    .scaledToFill()
                    .padding()
                }
                VStack {
                    Text(viewModel.title)
                    if let subtitle = viewModel.subtitle {
                        Text(subtitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(appEnvironment.theme.secondaryText))
                            .font(.body)
                    }
                }
            }
        }
}

public struct WKOnboardingViewModel {

    var title: String
    var cells: [WKOnboardingCellViewModel]

    public init(title: String, cells: [WKOnboardingCellViewModel]) {
        self.title = title
        self.cells = cells
    }

   public struct WKOnboardingCellViewModel {
        var icon: String?
        var title: String
        var subtitle: String?

        public init(icon: String?, title: String, subtitle: String?) {
            self.icon = icon
            self.title = title
            self.subtitle = subtitle
        }

    }
}
