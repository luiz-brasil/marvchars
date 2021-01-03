import UIKit

@testable import Marvchars

final class WindowInitializerSpy: WindowInitialization {
    private(set) var makeCalled = false
    var makeReturn: UIWindow = UIWindow()

    func make() -> UIWindow {
        makeCalled = true
        return makeReturn
    }
}
