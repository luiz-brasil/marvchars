import UIKit

protocol ApplicationInitialization {
    func initialize(on application: UIApplication)
}

final class ApplicationInitializer: ApplicationInitialization {
    private let windowInitializer: WindowInitialization
    private let tabBarInitializer: TabBarFactory

    init(
        windowInitializer: WindowInitialization = WindowInitializer(),
        tabBarInitializer: TabBarFactory = TabBarInitializer()
    ) {
        self.windowInitializer = windowInitializer
        self.tabBarInitializer = tabBarInitializer
    }

    func initialize(on application: UIApplication) {
        initializeUI()
    }

    private func initializeUI() {
        let window = windowInitializer.make()
        let viewController = tabBarInitializer.make()

        window.rootViewController = viewController
        window.makeKeyAndVisible()

        Current.ui.define(window: window)
    }
}
