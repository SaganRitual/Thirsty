// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ContentView: View {
    static let scaleFactor = 7.0
    static let sceneSide = scaleFactor * 100.0
    static let sceneRadius = sceneSide / 2
    static let sceneSize = CGSize(width: sceneSide, height: sceneSide)

    let arenaScene = ArenaScene(size: ContentView.sceneSize)

    var body: some View {
        SpriteView(scene: arenaScene)
            .frame(width: ContentView.sceneSide, height: ContentView.sceneSide)
            .scaledToFill()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
