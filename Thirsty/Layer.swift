// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

let lineHeight = 1.0   // Thin looks good, thick is easier to debug
let maxSpinarmFraction = 0.64
let minSpinarmFraction = 0.1
let penFraction = 0.42

class Layer {
    let pen: SKSpriteNode
    let roller: SKSpriteNode
    let spinarm: SKSpriteNode

    let penWidth: Double

    init(_ pen: SKSpriteNode, _ roller: SKSpriteNode, _ spinarm: SKSpriteNode) {
        self.pen = pen
        self.roller = roller
        self.spinarm = spinarm

        penWidth = pen.size.width
    }
}
