import UIKit

protocol ApplicationInitialization {
    func initialize(on application: UIApplication)
}

final class ApplicationInitializer: ApplicationInitialization {
    private let windowInitializer: WindowInitialization

    init(windowInitializer: WindowInitialization = WindowInitializer()) {
        self.windowInitializer = windowInitializer
    }

    func initialize(on application: UIApplication) {
        initializeUI()
    }

    private func initializeUI() {
        let window = windowInitializer.make()
        let viewController = ViewController()

        window.rootViewController = viewController
        window.makeKeyAndVisible()

        Current.ui.define(window: window)
    }
}
