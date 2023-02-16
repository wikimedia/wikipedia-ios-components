import SwiftUI
import Components

struct Empty2View: View {
    
    @EnvironmentObject var observableTheme: ObservableTheme
    // This will trigger body() again upon dynamic type size change, so that font sizes can scale up
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    
    var body: some View {
        Text("No items")
            .multilineTextAlignment(.center)
            .font(Font(emptyFont))
            .foregroundColor(Color(observableTheme.theme.colors.text))
    }
    
    private var emptyFont: UIFont {
        return UIFont.wmf_scaledSystemFont(forTextStyle: .title1, weight: .regular, size: 16)
    }
}
