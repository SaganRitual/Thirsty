// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class ArenaScene: SKScene, SKSceneDelegate {
    var layers = [Layer]()
    var tickCount = 0

    lazy var layerFactory = LayerFactory(arenaScene: self)

    override init(size: CGSize) {
        super.init(size: size)

        backgroundColor = SKColor.init(calibratedWhite: 0.2, alpha: 1)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        speed = 0.25
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        let sceneRing = layerFactory.ringsPool.makeSprite()
        sceneRing.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        sceneRing.color = .cyan
        sceneRing.size = self.frame.size

        self.addChild(sceneRing)

        self.fuckSpinarm = layerFactory.makeSpinarm(
            parentNode: self, spinarmRadiusShare: 1.0, color: .magenta
        )

        self.fuckRoller = layerFactory.makeRoller(spinarm: self.fuckSpinarm)
    }

    var fuckSpinarm: SKSpriteNode!
    var fuckRoller: SKSpriteNode!

    override func update(_ currentTime: TimeInterval) {
        tickCount += 1

        fuckRoller.position = CGPoint(x: fuckSpinarm.size.width, y: 0)
        fuckRoller.size.width = 2 * ((frame.size.width / 2) - fuckSpinarm.size.width)
        fuckRoller.size.height = fuckRoller.size.width
    }
}