import Foundation
import UIKit
import CoreGraphics

extension UIImage {
    static func wmf_imageFromColor(_ color: UIColor) -> UIImage? {
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill([rect])
        var image: UIImage?
        if let cgImage = context?.makeImage() {
            image = UIImage(cgImage: cgImage)
        }
        UIGraphicsEndImageContext();
        return image
    }
}
