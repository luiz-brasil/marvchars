import UIKit

@testable import Marvchars

struct UIMockEnvironment: UIEnvironment {
    var bounds: CGRect
    var window: UIWindow?

    mutating func define(window: UIWindow) {
        self.window = window
    }
}
