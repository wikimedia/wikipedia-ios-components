import SwiftUI

public struct WKEmptyView: View {

    @ObservedObject var appEnvironment = WKAppEnvironment.current
    var viewModel: WKEmptyViewModel

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(appEnvironment.theme.paperBackground)
                ScrollView {
                    VStack {
                        Spacer()
                        Image(uiImage: viewModel.image)
                            .frame(width: 132, height: 117)
                        Text(viewModel.title)
                            .font(WKFont.for(.boldBody))
                            .foregroundColor(Color(appEnvironment.theme.text))
                            .padding([.top], 12)
                            .padding([.bottom], 8)
                            .multilineTextAlignment(.center)
                         if let filter = viewModel.activeFilters, viewModel.type == .filter, filter > 0 {
                            Text(getFilterMessage())
                                .font(Font(WKFont.for(.footnote)))
                                .foregroundColor(Color(appEnvironment.theme.secondaryText))
                                .multilineTextAlignment(.center)
                        } else {
                            Text(viewModel.subtitle)
                                .font(Font(WKFont.for(.footnote)))
                                .foregroundColor(Color(appEnvironment.theme.secondaryText))
                                .multilineTextAlignment(.center)
                        }
                        if viewModel.type == .noItems, let buttonTitle = viewModel.buttonTitle {
                            Button(action: {
                                print("")
                            }, label: {
                                Text(buttonTitle)
                                    .font(Font(WKFont.for(.boldBody)))
                                    .foregroundColor(Color(appEnvironment.theme.link))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 46)
                                    .background(Color(appEnvironment.theme.baseBackground))
                                    .cornerRadius(8)
                                    .padding()
                            })
                        }
                        Spacer()
                    }
                    .frame(minHeight: geometry.size.height)
                    .padding([.leading, .trailing], 32)
                }
            }
        }
    }

    private func getFilterMessage() -> String {
        if let activeFilters = viewModel.activeFilters {

            return "filter text\(String(activeFilters))"
        }

        return ""
    }

}
