import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private var gameScene: GameScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            loadSceneInView(view)
        
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func didPressStart() {
        gameScene?.redrawScene()
    }

// MARK: - Private methods

    private func loadSceneInView(_ view: SKView) {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            gameScene = scene
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
        }
    }
}
