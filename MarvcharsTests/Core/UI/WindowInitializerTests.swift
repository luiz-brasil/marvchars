import UIKit
import XCTest

@testable import Marvchars

final class WindowInitializerTests: XCTestCase {
    private let sut = WindowInitializer()
    private let bounds = CGRect(x: .random(in: 0...1000), y: .random(in: 0...1000), width: .random(in: 0...1000), height: .random(in: 0...1000))

    override func setUp() {
        Current.ui = UIMockEnvironment(bounds: bounds)
    }

    func test_whenMake_windowWithRandomBoundsShouldBeCreated() {
        let window = sut.make()

        XCTAssertEqual(window.frame, bounds)
    }
}
