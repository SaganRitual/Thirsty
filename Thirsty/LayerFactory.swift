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
        rollerSprite.size = CGSize(width: size.width, height: lineHeight)
        rollerSprite.position = CGPoint(x: -spinarm.frame.size.width, y: 0)

        spinarm.addChild(rollerSprite)

        return rollerSprite
    }

    func makePen(rollerSprite: SKSpriteNode) -> SKSpriteNode {
        let penSprite = linesPool.makeSprite()

        penSprite.anchorPoint = CGPoint(x: 0, y: 0.5)

        penSprite.color = .yellow // rollerSprite.color
        penSprite.size = rollerSprite.size
        penSprite.zRotation = -.tau / 4

        rollerSprite.addChild(penSprite)

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

        let throbPlus = SKAction.resize(toWidth: 0.9 * arenaScene.frame.size.width / 2, duration: sqrt(2))
        throbPlus.timingMode = .easeInEaseOut
        let throbMinus = SKAction.resize(toWidth: 0.1 * arenaScene.frame.size.width / 2, duration: sqrt(3))
        throbMinus.timingMode = .easeInEaseOut
        let throb = SKAction.sequence([throbPlus, throbMinus])
        let throbForever = SKAction.repeatForever(throb)

//        spinnerSprite.run(throbForever)

        return spinnerSprite
    }
}

