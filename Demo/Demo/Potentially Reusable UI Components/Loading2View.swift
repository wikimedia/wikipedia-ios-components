import SwiftUI
import UIComponents

struct Loading2View: View {
    
    @EnvironmentObject var observableTheme: ObservableTheme
    
    var body: some View {
        ProgressView()
            .foregroundColor(Color(observableTheme.theme.colors.text))
    }
}
