import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var initializer: ApplicationInitialization = ApplicationInitializer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializer.initialize(on: application)

        return true
    }
}
