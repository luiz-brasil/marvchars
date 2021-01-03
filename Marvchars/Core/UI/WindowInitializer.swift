import UIKit

protocol WindowInitialization {
    func make() -> UIWindow
}

final class WindowInitializer: WindowInitialization {
    func make() -> UIWindow {
        let window = UIWindow(frame: Current.ui.bounds)

        return window
    }
}
