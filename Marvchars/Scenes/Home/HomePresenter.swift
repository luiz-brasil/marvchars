import UIKit

protocol HomePresentationLogic {
    func presentFetchResults(response: Home.Fetch.Response)
    func presentCharacterThumbnail(response: Home.GetImage.Response)
}

final class HomePresenter: HomePresentationLogic {
    private let displayer: HomeDisplayLogic

    init(displayer: HomeDisplayLogic) {
        self.displayer = displayer
    }

    func presentFetchResults(response: Home.Fetch.Response) {
        displayer.didFetchItems(
            with: .init(
                characters: response.characters.map {
                    Home.Fetch.ViewModel.Character(
                        name: $0.name,
                        pictureUrl: $0.picture)
                }
            )
        )
    }

    func presentCharacterThumbnail(response: Home.GetImage.Response) {
        guard let image = UIImage(data: response.data) else {
            return
        }

        displayer.didGetCaracterThumbnail(with: .init(image: image, url: response.url))
    }
}
