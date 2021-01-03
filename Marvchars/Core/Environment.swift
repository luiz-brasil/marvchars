import UIKit

protocol Environment {
    var ui: UIEnvironment { get set }
}

struct RealEnvironment: Environment {
    var ui: UIEnvironment

    init(uiEnvironment: UIEnvironment) {
        self.ui = uiEnvironment
    }
}

var Current: Environment = RealEnvironment(
    uiEnvironment: UIRealEnvironment()
)
