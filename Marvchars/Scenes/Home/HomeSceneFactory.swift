import UIKit

final class HomeSceneFactory: SceneFactory {
    private let networking: Networking
    private let queue = DispatchQueue(label: "home.character.thumbnail.getting")

    init(environment: Environment) {
        self.networking = environment.networking
    }

    func make() -> UIViewController {
        let displayer = HomeViewController()
        let presenter = HomePresenter(displayer: displayer)
        let interactor = HomeViewInteractor(
            networking: networking,
            presenter: presenter,
            queue: queue
        )


        displayer.inject(interactor: interactor)

        return displayer
    }
}
