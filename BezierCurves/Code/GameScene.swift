import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var startControlSegmentCircleNode: SKShapeNode?
    var centerControlSegmentCircleNode: SKShapeNode?
    var endControlSegmentCircleNode: SKShapeNode?
    var startSubcontrolLineNode: SKShapeNode?
    var endSubcontrolLineNode: SKShapeNode?

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
                        dotStrokeColor: .blue,
                        isDashed: true)

        let controlPoint1 = CGPoint(x: -250, y: 100)
        let controlPoint1Segment = LineSegment(startingPoint: lineSegment.startingPoint,
                                               endingPoint: controlPoint1)
        drawLineSegment(segment: controlPoint1Segment,
                        lineColor: .blue,
                        dotFillColor: .clear,
                        dotStrokeColor: .blue)

        let controlPoint2 = CGPoint(x: 120, y: 210)
        let controlPoint2Segment = LineSegment(startingPoint: lineSegment.endingPoint,
                                               endingPoint: controlPoint2)
        drawLineSegment(segment: controlPoint2Segment,
                        lineColor: .blue,
                        dotFillColor: .clear,
                        dotStrokeColor: .blue)

        let controlSegment = LineSegment(startingPoint: controlPoint1,
                                         endingPoint: controlPoint2)
        drawLineSegment(segment: controlSegment,
                        lineColor: .white,
                        dotFillColor: .clear,
                        dotStrokeColor: .blue,
                        isDashed: true)

        startControlSegmentCircleNode = interpolateLineSegment(segment: controlPoint1Segment,
                                                                dotFillColor: .green,
                                                                dotStrokeColor: .green)
        centerControlSegmentCircleNode = interpolateLineSegment(segment: controlSegment,
                                                                dotFillColor: .green,
                                                                dotStrokeColor: .green)
        endControlSegmentCircleNode = interpolateLineSegment(segment: controlPoint2Segment,
                                                             dotFillColor: .green,
                                                             dotStrokeColor: .green,
                                                             reverse: true)
        let path1 = CGMutablePath();
        path1.move(to: controlPoint1Segment.startingPoint)
        path1.addLine(to: controlSegment.startingPoint)
        startSubcontrolLineNode = SKShapeNode(path: path1)
        startSubcontrolLineNode?.strokeColor = .green
        addChild(startSubcontrolLineNode!)

        let path2 = CGMutablePath();
        path2.move(to: controlPoint2Segment.endingPoint)
        path2.addLine(to: controlSegment.startingPoint)
        endSubcontrolLineNode = SKShapeNode(path: path2)
        endSubcontrolLineNode?.strokeColor = .green
        addChild(endSubcontrolLineNode!)
    }

    func updateStartSubcontrolLineNode() {
        guard let startControlSegmentCircleNode = startControlSegmentCircleNode,
            let centerControlSegmentCircleNode = centerControlSegmentCircleNode,
            let startSubcontrolLineNode = startSubcontrolLineNode else {
            return
        }
        let path = CGMutablePath();
        path.move(to: startControlSegmentCircleNode.position)
        path.addLine(to: centerControlSegmentCircleNode.position)
        startSubcontrolLineNode.path = path
    }

    func updateEndSubcontrolLineNode() {
        guard let endControlSegmentCircleNode = endControlSegmentCircleNode,
            let centerControlSegmentCircleNode = centerControlSegmentCircleNode,
            let endSubcontrolLineNode = endSubcontrolLineNode else {
            return
        }
        let path = CGMutablePath();
        path.move(to: centerControlSegmentCircleNode.position)
        path.addLine(to: endControlSegmentCircleNode.position)
        endSubcontrolLineNode.path = path
    }

    func drawLineSegment(segment: LineSegment,
                         lineColor: SKColor,
                         dotFillColor: SKColor,
                         dotStrokeColor: SKColor,
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
        startCircle.strokeColor = dotStrokeColor
        startCircle.fillColor = dotFillColor
        addChild(startCircle)

        let endCircle = SKShapeNode(circleOfRadius: circleRadius)
        endCircle.position = segment.endingPoint
        endCircle.strokeColor = dotStrokeColor
        endCircle.fillColor = dotFillColor
        addChild(endCircle)
    }

    @discardableResult
    func interpolateLineSegment(segment: LineSegment,
                                dotFillColor: SKColor,
                                dotStrokeColor: SKColor,
                                reverse: Bool = false) -> SKShapeNode {

        let circleRadius: CGFloat = 5
        let circle = SKShapeNode(circleOfRadius: circleRadius)
        let start = reverse ? segment.endingPoint : segment.startingPoint
        let end = reverse ? segment.startingPoint : segment.endingPoint
        circle.position = start
        circle.strokeColor = dotStrokeColor
        circle.fillColor = dotFillColor
        addChild(circle)

        let moveAction = SKAction.move(to: end, duration: 2.0)
        circle.run(moveAction)

        return circle
    }

    override func update(_ currentTime: TimeInterval) {
        updateStartSubcontrolLineNode()
        updateEndSubcontrolLineNode()
    }
}
