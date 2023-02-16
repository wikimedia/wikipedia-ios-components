import SwiftUI
import UIComponents

struct Feature2View: View {
    
    @EnvironmentObject var observableTheme: ObservableTheme
    
    private let fetcher = FeatureFetcher()
    
    @State private var items: [Feature1ItemViewModel] = []
    @State private var error: Error?
    @State private var isLoading: Bool = false
    
    var body: some View {
        Group {
            if isLoading {
                Loading2View()
            } else if error != nil {
                Error2View()
            } else if items.isEmpty {
                Empty2View()
            } else if !items.isEmpty {
                Data2View(items: items)
            }
        }
        .background(Color(observableTheme.theme.colors.baseBackground))
        .onAppear {
            isLoading = true
            fetcher.fetchItems { result in
                self.isLoading = false
                switch result {
                case .success(let items):
                    self.items = items
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
}

struct Feature2View_Previews: PreviewProvider {
    static var previews: some View {
        Feature2View()
    }
}
