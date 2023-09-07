import SwiftUI

public struct WKEmptyView: View {

    @ObservedObject var appEnvironment = WKAppEnvironment.current
    @ObservedObject var viewModel: WKEmptyViewModel
    var delegate: WKWatchlistDelegate?
    var type: WKEmptyViewModel.EmptyStateType

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(appEnvironment.theme.paperBackground)
                ScrollView {
                    VStack {
                        Spacer()
                        Image(uiImage: viewModel.image)
                            .frame(width: 132, height: 118)
                        Text(viewModel.localizedStrings.title)
                            .font(Font(WKFont.for(.boldBody)))
                            .foregroundColor(Color(appEnvironment.theme.text))
                            .padding([.top], 12)
                            .padding([.bottom], 8)
                            .multilineTextAlignment(.center)
                        if type == .filter {
                            WKEmptyViewFilterView(delegate: delegate, viewModel: viewModel)
                        } else {
                            Text(viewModel.localizedStrings.subtitle)
                                .font(Font(WKFont.for(.footnote)))
                                .foregroundColor(Color(appEnvironment.theme.secondaryText))
                                .multilineTextAlignment(.center)
                        }
                        if type == .noItems {
                            WKSecondaryButton(title: viewModel.localizedStrings.buttonTitle, action: delegate?.emptyViewDidTapExplore)
                                .padding([.leading, .trailing], 32)
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

    @ObservedObject var appEnvironment = WKAppEnvironment.current
    var delegate: WKWatchlistDelegate?
    var viewModel: WKEmptyViewModel

    var body: some View {

        HStack(spacing: 0) {
            Text(viewModel.localizedStrings.filterSubtitleModify)
                .font(Font(WKFont.for(.footnote)))
                .foregroundColor(Color(appEnvironment.theme.secondaryText))
                .multilineTextAlignment(.center)
                .padding(0)
            Button(action: {
                
                delegate?.emptyViewDidTapFilters()
            }, label: {
                Text(viewModel.filterString(localizedStrings: viewModel.localizedStrings))
                    .font(Font(WKFont.for(.footnote)))
                    .foregroundColor(Color(appEnvironment.theme.link))
                    .padding(2)
                    .frame(height: 30)
                    .background(Color(appEnvironment.theme.paperBackground))
            })
            .padding(0)
            Text(viewModel.localizedStrings.filterSubtitleSeeMore)
                .font(Font(WKFont.for(.footnote)))
                .foregroundColor(Color(appEnvironment.theme.secondaryText))
                .multilineTextAlignment(.center)
                .padding(0)
        }
    }

}
