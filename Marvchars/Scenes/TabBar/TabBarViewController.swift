import UIKit

final class TabBarViewController: UITabBarController {
    private let tabFactory: TabFactory

    init(tabFactory: TabFactory) {
        self.tabFactory = tabFactory

        super.init(nibName: nil, bundle: nil)

        let tabs = tabFactory.makeAllTabs()

        viewControllers = tabs
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}
