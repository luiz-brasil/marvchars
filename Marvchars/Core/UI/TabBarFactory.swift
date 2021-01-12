import UIKit

protocol TabBarFactory {
    func make() -> UITabBarController
}

final class TabBarInitializer: TabBarFactory {
    private let tabFactory: TabFactory

    init(tabFactory: TabFactory) {
        self.tabFactory = tabFactory
    }

    func make() -> UITabBarController {
        TabBarViewController(tabFactory: tabFactory)
    }
}
