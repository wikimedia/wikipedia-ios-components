import SwiftUI

public struct WKOnboardingView: View {

    // MARK: - Properties

    var viewModel: WKOnboardingViewModel
    var mainButtonAction: (() -> Void)?
    var secondaryButtonAction: (() -> Void)?

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    // MARK: - Lifecycle

    public var body: some View {
        Group {
            ScrollView {
                VStack {
                    Color(appEnvironment.theme.paperBackground)
                        .ignoresSafeArea()
                    Text(viewModel.title)
                        .font(WKFont.for(.title).bold())
                        .padding([.bottom, .top], 44)
                        .multilineTextAlignment(.center)
                    ForEach (1...viewModel.cells.count, id:\.self) { cell in
                        VStack {
                            WKOnboardingCell(viewModel: viewModel.cells[cell - 1])
                                .padding([.bottom, .trailing], 20)
                        }
                    }

                    Group {
                        Button(action: {
                            mainButtonAction?()
                        }, label: {
                            Text(viewModel.mainButtonTitle)
                        })
                        .font(WKFont.for(.subheadline).bold())
                        .foregroundColor(Color(appEnvironment.theme.paperBackground))
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background(Color(appEnvironment.theme.link))
                        .cornerRadius(8)

                        if let secondaryButton = viewModel.secondaryButtonTitle {
                            Button(action: {
                                secondaryButtonAction?()
                            }, label: {
                                Text(secondaryButton)
                            })
                            .font(WKFont.for(.subheadline).bold())
                            .foregroundColor(Color(appEnvironment.theme.link))
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(Color(appEnvironment.theme.paperBackground))
                            .cornerRadius(8)

                        }
                    }

                }
                .padding(32)
            }
        }
    }
}
