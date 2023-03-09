import SwiftUI
import Components

struct Data2View: View {
    
    @EnvironmentObject var observableTheme: ObservableTheme
    // This will trigger body() again upon dynamic type size change, so that font sizes can scale up
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    
    let items: [Feature1ItemViewModel]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(items) { item in
                    Text(item.title)
                        .font(Font(itemFont))
                        .foregroundColor(Color(observableTheme.theme.colors.text))
                }
            }
        }
    }
    
    private var itemFont: UIFont {
        return UIFont.wmf_scaledSystemFont(forTextStyle: .title1, weight: .bold, size: 14)
    }
}
