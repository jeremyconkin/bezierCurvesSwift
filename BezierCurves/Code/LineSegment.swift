import CoreGraphics

struct LineSegment {
    let startingPoint: Point
    let endingPoint: Point
    
    func interpolatedPoint(interpolationPercentage: CGFloat) -> Point {
        let clampedPercentage = interpolationPercentage.clamped((0...1))
        let segmentMagnitude = endingPoint - startingPoint
        let returnVal = startingPoint + (segmentMagnitude * clampedPercentage)
        return returnVal
    }
}
