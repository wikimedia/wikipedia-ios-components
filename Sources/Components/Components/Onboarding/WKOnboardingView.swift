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
                        .padding([.bottom, .top], 44)
                        .multilineTextAlignment(.center)
                    ForEach (1...viewModel.cells.count, id:\.self) { cell in
                        VStack {
                            WKOnboardingCell(viewModel: viewModel.cells[cell - 1])
                                .padding([.bottom, .trailing], 20)

                        }
                    }
                }
                .padding(32)
            }
        }
    }
}

struct WKOnboardingCell: View {

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    var viewModel: WKOnboardingViewModel.WKOnboardingCellViewModel

    var body: some View {
            HStack {
                VStack {
                    if let icon = viewModel.icon {
                        Image(systemName: icon)
                            .frame(width: 24, alignment: .top)
                            .accessibilityHidden(true)
                            .scaledToFill()
                            .padding([.trailing], 16)
                            .padding([.top], 5)
                    }
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .multilineTextAlignment(.leading)
                    if let subtitle = viewModel.subtitle {
                        Text(subtitle)
                            .multilineTextAlignment(.leading)
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
