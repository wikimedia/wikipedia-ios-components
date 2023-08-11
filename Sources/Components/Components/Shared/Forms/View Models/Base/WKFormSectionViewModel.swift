import Foundation

class WKFormSectionViewModel: Identifiable {
    let id = UUID()
    let header: String?
    let footer: String?
    
    init(header: String?, footer: String?) {
        self.header = header
        self.footer = footer
    }
}
