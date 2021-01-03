import UIKit

protocol UIEnvironment {
    var bounds: CGRect { get }
    var window: UIWindow? { get set }

    mutating func define(window: UIWindow)
}

struct UIRealEnvironment: UIEnvironment {
    var bounds: CGRect {
        UIScreen.main.bounds
    }

    var window: UIWindow?

    mutating func define(window: UIWindow) {
        self.window = window
    }
}
