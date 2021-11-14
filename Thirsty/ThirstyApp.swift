// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

extension Double {
    static let tau = 2 * Double.pi
}

extension CGFloat {
    static let tau = 2 * CGFloat.pi
}

@main
struct ThirstyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
