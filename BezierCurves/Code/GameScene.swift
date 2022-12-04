import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var lineSegment: LineSegment? {
        didSet {
            redrawScene()
        }
    }

    override func didMove(to view: SKView) {
        lineSegment = LineSegment(startingPoint: CGPoint(x: -300, y: -200),
                                  endingPoint: CGPoint(x: 300, y: 30))
    }

    private func redrawScene() {
        removeAllChildren()
        guard let lineSegment = lineSegment else {
            return
        }

        drawLineSegment(segment: lineSegment,
                        lineColor: .white,
                        dotFillColor: .blue,
                        dotPathColor: .blue,
                        isDashed: true)

        let controlPoint1 = CGPoint(x: -250, y: 100)
        let controlPoint1Segment = LineSegment(startingPoint: lineSegment.startingPoint,
                                               endingPoint: controlPoint1)
        drawLineSegment(segment: controlPoint1Segment,
                        lineColor: .blue,
                        dotFillColor: .clear,
                        dotPathColor: .blue)

        let controlPoint2 = CGPoint(x: 120, y: 210)
        let controlPoint2Segment = LineSegment(startingPoint: lineSegment.endingPoint,
                                               endingPoint: controlPoint2)
        drawLineSegment(segment: controlPoint2Segment,
                        lineColor: .blue,
                        dotFillColor: .clear,
                        dotPathColor: .blue)

        let controlSegment = LineSegment(startingPoint: controlPoint1,
                                         endingPoint: controlPoint2)
        drawLineSegment(segment: controlSegment,
                        lineColor: .white,
                        dotFillColor: .clear,
                        dotPathColor: .blue,
                        isDashed: true)
    }

    func drawLineSegment(segment: LineSegment,
                         lineColor: SKColor,
                         dotFillColor: SKColor,
                         dotPathColor: SKColor,
                         isDashed:Bool = false) {
        let path = CGMutablePath();
        path.move(to: segment.startingPoint)
        path.addLine(to: segment.endingPoint)
        let pathToAdd = isDashed
                ? path.copy(dashingWithPhase: 0, lengths: [2])
                : path
        let line = SKShapeNode(path: pathToAdd)
        line.strokeColor = lineColor
        addChild(line)

        let circleRadius: CGFloat = 5
        let startCircle = SKShapeNode(circleOfRadius: circleRadius)
        startCircle.position = segment.startingPoint
        startCircle.strokeColor = dotPathColor
        startCircle.fillColor = dotFillColor
        addChild(startCircle)

        let endCircle = SKShapeNode(circleOfRadius: circleRadius)
        endCircle.position = segment.endingPoint
        endCircle.strokeColor = dotPathColor
        endCircle.fillColor = dotFillColor
        addChild(endCircle)
    }
}
