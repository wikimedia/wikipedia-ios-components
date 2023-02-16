import SwiftUI
import UIComponents

struct Error2View: View {
    
    @EnvironmentObject var observableTheme: ObservableTheme
    // This will trigger body() again upon dynamic type size change, so that font sizes can scale up
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    
    var body: some View {
        Text("There has been an error")
            .multilineTextAlignment(.center)
            .font(Font(errorFont))
            .foregroundColor(Color(observableTheme.theme.colors.text))
    }
    
    private var errorFont: UIFont {
        return UIFont.wmf_scaledSystemFont(forTextStyle: .title1, weight: .regular, size: 16)
    }
}
