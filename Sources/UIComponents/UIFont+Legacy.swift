import Foundation
import UIKit

public enum FontFamily: Int {
    case system
    case georgia
}

public class DynamicTextStyle {
    public static let boldTitle1 = DynamicTextStyle(.system, .title1, .bold)
    public static let italicBody = DynamicTextStyle(.system, .body, .regular,  [UIFontDescriptor.SymbolicTraits.traitItalic])
    public static let georgiaTitle3 = DynamicTextStyle(.georgia, .title3)
    
    let family: FontFamily
    let style: UIFont.TextStyle
    let weight: UIFont.Weight
    let traits: UIFontDescriptor.SymbolicTraits
    
    init(_ family: FontFamily = .system, _ style: UIFont.TextStyle, _ weight: UIFont.Weight = .regular, _ traits: UIFontDescriptor.SymbolicTraits = []) {
        self.family = family
        self.weight = weight
        self.traits = traits
        self.style = style
    }
}

public extension UIFont {
    
    static func wmf_font(_ dynamicTextStyle: DynamicTextStyle) -> UIFont {
        return UIFont.wmf_font(dynamicTextStyle, compatibleWithTraitCollection: UITraitCollection(preferredContentSizeCategory: .large))
    }
    
    static func wmf_font(_ dynamicTextStyle: DynamicTextStyle, compatibleWithTraitCollection traitCollection: UITraitCollection) -> UIFont {
        let fontFamily = dynamicTextStyle.family
        let weight = dynamicTextStyle.weight
        let traits = dynamicTextStyle.traits
        let style = dynamicTextStyle.style
        guard fontFamily != .system || weight != .regular || traits != [] else {
            return UIFont.preferredFont(forTextStyle: style, compatibleWith: traitCollection)
        }
        
        let size: CGFloat = UIFont.preferredFont(forTextStyle: style, compatibleWith: traitCollection).pointSize

        var font: UIFont
        switch fontFamily {
        case .georgia:
            // using the standard .with(traits: doesn't seem to work for georgia
            let isBold = weight > UIFont.Weight.regular
            let isItalic = traits.contains(.traitItalic)
            if isBold && isItalic {
                font = UIFont(descriptor: UIFontDescriptor(name: "Georgia-BoldItalic", size: size), size: 0)
            } else if isBold {
                font = UIFont(descriptor: UIFontDescriptor(name: "Georgia-Bold", size: size), size: 0)
            } else if isItalic {
                font = UIFont(descriptor: UIFontDescriptor(name: "Georgia-Italic", size: size), size: 0)
            } else {
                font = UIFont(descriptor: UIFontDescriptor(name: "Georgia", size: size), size: 0)
            }
        case .system:
            font = weight != .regular ? UIFont.systemFont(ofSize: size, weight: weight) : UIFont.preferredFont(forTextStyle: style, compatibleWith: traitCollection)
            if traits != [] {
                font = font.with(traits: traits)
            }
        }
        return font
    }
    
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        
        return UIFont(descriptor: descriptor, size: 0)
    }
}
