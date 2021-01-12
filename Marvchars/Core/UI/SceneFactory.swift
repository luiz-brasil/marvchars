import UIKit

protocol SceneFactory: AnyObject {
    init(environment: Environment)
    func make() -> UIViewController
}
