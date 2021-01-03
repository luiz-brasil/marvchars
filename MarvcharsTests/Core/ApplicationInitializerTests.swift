import UIKit
import XCTest

@testable import Marvchars

final class ApplicationInitializerTests: XCTestCase {
    private let windowInitializerSpy = WindowInitializerSpy()
    private lazy var sut = ApplicationInitializer(
        windowInitializer: windowInitializerSpy
    )

    func test_whenInitializeUI_aNewWindowShouldBeMaked() {
        let expectedWindow = UIWindow()

        windowInitializerSpy.makeReturn = expectedWindow

        sut.initialize(on: UIApplication.shared)

        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }

        XCTAssertEqual(expectedWindow, keyWindow)
        XCTAssertTrue(expectedWindow.rootViewController is ViewController)
        XCTAssertEqual(expectedWindow, Current.ui.window)
    }
}
