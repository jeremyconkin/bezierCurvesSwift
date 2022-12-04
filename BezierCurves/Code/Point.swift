import CoreGraphics

typealias Point = CGPoint

extension Point {
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func -(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func *(lhs: Point, rhs: CGFloat) -> Point {
        return Point(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    static func *(lhs: CGFloat, rhs: Point) -> Point {
        return rhs * lhs
    }
}
