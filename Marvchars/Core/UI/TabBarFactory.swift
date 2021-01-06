import UIKit

protocol TabBarFactory {
    func make() -> UITabBarController
}

final class TabBarInitializer: TabBarFactory {
    func make() -> UITabBarController {
        UITabBarController()
    }
}
