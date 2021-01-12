import UIKit

protocol Environment {
    var ui: UIEnvironment { get set }
    var networking: Networking { get set }
}

struct RealEnvironment: Environment {
    var ui: UIEnvironment
    var networking: Networking

    init(uiEnvironment: UIEnvironment, networking: Networking) {
        self.ui = uiEnvironment
        self.networking = networking
    }
}

var Current: Environment = RealEnvironment(
    uiEnvironment: UIRealEnvironment(),
    networking: WebClient()
)
