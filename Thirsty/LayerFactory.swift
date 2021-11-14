// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class LayerFactory {
    let ringsPool = SpritePool("Markers", "circle", cPreallocate: 10000)
    let linesPool = SpritePool("Markers", "line")

    let arenaScene: ArenaScene

    init(arenaScene: ArenaScene) {
        self.arenaScene = arenaScene
    }
}

extension LayerFactory {
    func makeRoller(spinarm: SKNode) -> SKSpriteNode {
        let spinarmRawDiameter = spinarm.frame.size.width
        let spinarmRawRadius = spinarmRawDiameter / 2
        let size = CGSize(width: (spinarm as? SKSpriteNode)!.size.width, height: (spinarm as? SKSpriteNode)!.size.width)

        let rollerSprite = ringsPool.makeSprite()

        rollerSprite.color = ((spinarm as? SKSpriteNode)?.color ?? .red)
        rollerSprite.size = size
        rollerSprite.position = CGPoint(x: -spinarm.frame.size.width, y: 0)

        spinarm.addChild(rollerSprite)
//
//        let fractionToSceneRadius = arenaScene.frame.size.width / size.width
//        let driveAngle = -fractionToSceneRadius * Double.tau
//
//        let roll = SKAction.rotate(byAngle: driveAngle, duration: 4)
//        let rollForever = SKAction.repeatForever(roll)
//        rollerSprite.run(rollForever)

        return rollerSprite
    }

    func makeSpinarm(
        parentNode: SKNode, spinarmRadiusShare: Double, color: SKColor
    ) -> SKSpriteNode {
        let parentRollerRadius = parentNode.frame.size.width / 2
        let size = CGSize(width: maxSpinarmFraction * parentRollerRadius, height: lineHeight)

        let spinnerSprite = linesPool.makeSprite()
        spinnerSprite.anchorPoint = CGPoint(x: 0, y: 0.5)

        spinnerSprite.color = color
        spinnerSprite.size = size

        parentNode.addChild(spinnerSprite)

        let spin = SKAction.rotate(byAngle: CGFloat.tau, duration: 4)
        let spinForever = SKAction.repeatForever(spin)

        let throbPlus = SKAction.resize(toWidth: 0.9 * arenaScene.frame.size.width / 2, duration: sqrt(2))
        throbPlus.timingMode = .easeInEaseOut
        let throbMinus = SKAction.resize(toWidth: 0.1 * arenaScene.frame.size.width / 2, duration: sqrt(3))
        throbMinus.timingMode = .easeInEaseOut
        let throb = SKAction.sequence([throbPlus, throbMinus])
        let throbForever = SKAction.repeatForever(throb)

        spinnerSprite.userData = [
            "spinForever": spinForever,
            "throbForever": throbForever
        ]

        spinnerSprite.run(spinForever)
        spinnerSprite.run(throbForever)

        return spinnerSprite
    }
}

