import UIKit

protocol TabFactory {
    func make(tab: Tab) -> UIViewController?
    func makeAllTabs() -> [UIViewController]
}

final class TabInitializer: TabFactory {
    private let environment: Environment

    init(environment: Environment) {
        self.environment = environment
    }

    func make(tab: Tab) -> UIViewController? {
        guard let factoryType = NSClassFromString("Marvchars.\(tab.rawValue)") as? SceneFactory.Type else {
            return nil
        }

        let factory = factoryType.init(environment: Current)
        let viewController = factory.make()

        return viewController
    }

    func makeAllTabs() -> [UIViewController] {
        Tab.allCases.compactMap(make)
    }
}
