import SwiftUI

public protocol WKEmptyViewDelegate: Any {
    func didPressPrimaryButton()
    func didPressFilterButton()
}

public struct WKEmptyView: View {

    @ObservedObject var appEnvironment = WKAppEnvironment.current
    var viewModel: WKEmptyViewModel
    var delegate: WKEmptyViewDelegate?

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
                                delegate?.didPressPrimaryButton()
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

}

struct WKEmptyViewFilterView: View {
    var body: some View {

        @ObservedObject var appEnvironment = WKAppEnvironment.current
        var delegate: WKEmptyViewDelegate?
        // get localized strings
        HStack(spacing: 0) {
            Text("Modify")
                .font(Font(WKFont.for(.footnote)))
                .foregroundColor(Color(appEnvironment.theme.secondaryText))
                .multilineTextAlignment(.center)
                .padding(0)
            Button(action: {
                delegate?.didPressFilterButton()
            }, label: {
                Text("3 filters")
                    .font(Font(WKFont.for(.footnote)))
                    .foregroundColor(Color(appEnvironment.theme.link))
                    .padding(2)
                    .frame(height: 30)
                    .background(Color(appEnvironment.theme.paperBackground))
            })
            .padding(0)
            Text("to see more Watchlist items.")
                .font(Font(WKFont.for(.footnote)))
                .foregroundColor(Color(appEnvironment.theme.secondaryText))
                .multilineTextAlignment(.center)
                .padding(0)
        }
    }

}
