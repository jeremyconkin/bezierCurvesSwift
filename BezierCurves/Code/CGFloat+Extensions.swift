import Foundation
import CoreGraphics

extension CGFloat {
    func clamped(_ range: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.maximum(range.lowerBound, CGFloat.minimum(range.upperBound, self))
    }
}

