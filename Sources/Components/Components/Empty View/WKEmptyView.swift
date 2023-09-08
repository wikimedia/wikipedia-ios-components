import SwiftUI

public protocol WKEmptyViewDelegate: AnyObject {
    func emptyViewDidTapSearch()
    func emptyViewDidTapFilters()
}

public struct WKEmptyView: View {

    @ObservedObject var appEnvironment = WKAppEnvironment.current
    @ObservedObject var viewModel: WKEmptyViewModel
    var delegate: WKEmptyViewDelegate?
    var type: WKEmptyViewStateType

    public var body: some View {
        GeometryReader { geometry in

            ZStack {
                Color(appEnvironment.theme.paperBackground)
                    .ignoresSafeArea()
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
                            WKResizableButton(title: viewModel.localizedStrings.buttonTitle, action: delegate?.emptyViewDidTapSearch)
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
    var delegate: WKEmptyViewDelegate?
    @ObservedObject var viewModel: WKEmptyViewModel

    var body: some View {

        if #available(iOS 15, *) { //TODO: remove check after updating deployment target
            var attributedString: AttributedString {
                let subtitle = viewModel.filterSubtitleString(localizedStrings: viewModel.localizedStrings)
                let subtitleNumberOfFilters = viewModel.filterString(localizedStrings: viewModel.localizedStrings)
                var attributedString = AttributedString(subtitle)
                attributedString.foregroundColor = Color(appEnvironment.theme.secondaryText)

                let range = attributedString.range(of: subtitleNumberOfFilters)!
                attributedString[range].foregroundColor = Color(appEnvironment.theme.link)
                
                return attributedString
            }

            HStack(spacing: 0) {
                Button(action: {
                    delegate?.emptyViewDidTapFilters()
                }, label: {
                    Text(attributedString)
                        .font(Font(WKFont.for(.footnote)))
                        .foregroundColor(Color(appEnvironment.theme.link))
                        .padding(2)
                        .frame(height: 30)
                        .background(Color(appEnvironment.theme.paperBackground))
                })
                .padding(0)
            }
        }
    }
}
