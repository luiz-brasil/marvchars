import XCTest

@testable import Marvchars

final class AppDelegateTests: XCTestCase {
    private let initializer = ApplicationInitializerSpy()
    private lazy var sut: AppDelegate = {
        let sut = AppDelegate()

        sut.initializer = initializer

        return sut
    }()

    func test_givenApplicationDidFinishLauching_initializerInitializeOnShouldBeCalled() {
        XCTAssertTrue(sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil))
        XCTAssertTrue(initializer.initializeCalled)
        XCTAssertEqual(initializer.initializeOnApplicationPassed, UIApplication.shared)
    }
}
