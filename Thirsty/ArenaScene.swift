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
        speed = 1
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

        layers.append(layerFactory.makeLayer())
    }

    static let rotationPeriodSeconds: TimeInterval = 10

    override func update(_ currentTime: TimeInterval) {
        tickCount += 1

        for layer in layers {
            layer.roller.position = CGPoint(x: layer.spinarm.size.width, y: 0)
            layer.roller.size.width = 2 * ((frame.size.width / 2) - layer.spinarm.size.width)
            layer.roller.size.height = layer.roller.size.width

            let fractionToSceneRadius = frame.size.width / layer.roller.size.width
            let rollAngle = fractionToSceneRadius * Double.tau / (60 * ArenaScene.rotationPeriodSeconds)

            let spinAngle = Double.tau / (60 * ArenaScene.rotationPeriodSeconds)

            layer.spinarm.zRotation += spinAngle
            layer.roller.zRotation -= spinAngle + rollAngle

            let easyDot = layerFactory.dotsPool.makeSprite()
            easyDot.size = CGSize(width: 5, height: 5)
            easyDot.color = .yellow
            easyDot.alpha = 0.85

            let tipPosition = CGPoint(x: layer.penWidth, y: 0)
            let dotPosition = layer.pen.convert(tipPosition, to: self)

            easyDot.position = dotPosition
            self.addChild(easyDot)

            let pathFadeDurationSeconds: TimeInterval = 5
            let fade = SKAction.fadeOut(withDuration: pathFadeDurationSeconds)
            easyDot.run(fade) {
                self.layerFactory.dotsPool.releaseSprite(easyDot)
            }
        }
    }
}
