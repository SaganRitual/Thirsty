// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class LayerFactory {
    let dotsPool = SpritePool("Markers", "circle-solid", cPreallocate: 10000)
    let linesPool = SpritePool("Markers", "line")
    let ringsPool = SpritePool("Markers", "circle")

    let arenaScene: ArenaScene

    init(arenaScene: ArenaScene) {
        self.arenaScene = arenaScene
    }

    func makeLayer() -> Layer {
        let spinarm = makeSpinarm(parentNode: arenaScene, color: .magenta)
        let roller = makeRoller(spinarm: spinarm)
        let pen = makePen(rollerSprite: roller)

        return Layer(pen, roller, spinarm)
    }
}

extension LayerFactory {
    func makeRoller(spinarm: SKSpriteNode) -> SKSpriteNode {
        let size = CGSize(width: spinarm.size.width, height: spinarm.size.width)

        let rollerSprite = ringsPool.makeSprite()

        rollerSprite.color = spinarm.color
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

        rollerSprite.addChild(penSprite)

        return rollerSprite
    }

    func makeSpinarm(
        parentNode: SKNode, color: SKColor
    ) -> SKSpriteNode {
        let parentRollerRadius = parentNode.frame.size.width / 2
        let size = CGSize(width: maxSpinarmFraction * parentRollerRadius, height: lineHeight)

        let spinnerSprite = linesPool.makeSprite()
        spinnerSprite.anchorPoint = CGPoint(x: 0, y: 0.5)

        spinnerSprite.color = color
        spinnerSprite.size = size

        parentNode.addChild(spinnerSprite)

        // Stress test
        let throbPlus = SKAction.resize(toWidth: 0.9 * arenaScene.frame.size.width / 2, duration: sqrt(2))
        throbPlus.timingMode = .easeInEaseOut
        let throbMinus = SKAction.resize(toWidth: 0.1 * arenaScene.frame.size.width / 2, duration: sqrt(3))
        throbMinus.timingMode = .easeInEaseOut
        let throb = SKAction.sequence([throbPlus, throbMinus])
        let throbForever = SKAction.repeatForever(throb)

        spinnerSprite.run(throbForever)

        return spinnerSprite
    }
}

