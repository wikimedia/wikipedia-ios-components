import SwiftUI

public struct WKOnboardingView: View {

    // MARK: - Properties

    var viewModel: WKOnboardingViewModel
    var mainButtonAction: (() -> Void)?
    var secondaryButtonAction: (() -> Void)?

    @ObservedObject var appEnvironment = WKAppEnvironment.current

    @Environment (\.horizontalSizeClass) private var horizontalSizeClass

    var sizeClassPadding: CGFloat {
        horizontalSizeClass == .regular ? 64 : 32
    }

    // MARK: - Lifecycle

    public var body: some View {
        ZStack {
            Color(appEnvironment.theme.paperBackground)
                .ignoresSafeArea()
            ScrollView(showsIndicators: true) {
                VStack {
                    Text(viewModel.title)
                        .font(Font(WKFont.for(.boldTitle)))
                        .padding([.bottom, .top], 44)
                        .multilineTextAlignment(.center)
                    ForEach (1...viewModel.cells.count, id:\.self) { cell in
                        VStack {
                            WKOnboardingCell(viewModel: viewModel.cells[cell - 1])
                                .padding([.bottom, .trailing], 20)
                        }
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            mainButtonAction?()
                        }, label: {
                            Text(viewModel.mainButtonTitle)
                        })
                        .font(Font(WKFont.for(.boldSubheadline)))
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
                            .font(Font(WKFont.for(.boldSubheadline)))
                            .foregroundColor(Color(appEnvironment.theme.link))
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(Color(appEnvironment.theme.paperBackground))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(sizeClassPadding)
            }
        }
    }
}
