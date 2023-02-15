import Foundation

public protocol Themeable: AnyObject {
    func apply(theme: Theme)
}
