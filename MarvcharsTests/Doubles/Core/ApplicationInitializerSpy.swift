import UIKit

@testable import Marvchars

final class ApplicationInitializerSpy: ApplicationInitialization {
    private(set) var initializeCalled = false
    private(set) var initializeOnApplicationPassed: UIApplication?

    func initialize(on application: UIApplication) {
        initializeCalled = true
        initializeOnApplicationPassed = application
    }
}
