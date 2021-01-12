import Foundation

protocol HomeViewBusinessLogic {
    func fetchItems(request: Home.Fetch.Request)
    func getCharacterThumbnail(request: Home.GetImage.Request)
}

final class HomeViewInteractor: HomeViewBusinessLogic {
    private let networking: Networking
    private let presenter: HomePresentationLogic
    private let queue: DispatchQueue

    init(networking: Networking, presenter: HomePresentationLogic,  queue: DispatchQueue) {
        self.networking = networking
        self.presenter = presenter
        self.queue = queue
    }

    func fetchItems(request: Home.Fetch.Request) {
        networking.fetch(request: CharacterRequest()) { [presenter] (result: Result<CharacterDataWrapper<Character>, Error>) in
            switch result {
            case .success(let payload):
                let characters = payload.data.results.compactMap { character -> Home.Fetch.Response.Character? in
                    guard let url = URL(string: "\(character.thumbnail.path).\(character.thumbnail.extension)") else {
                        return nil
                    }

                    return Home.Fetch.Response.Character(
                        name: character.name,
                        picture: url
                    )
                }

                let response = Home.Fetch.Response(characters: characters)

                DispatchQueue.main.async {
                    presenter.presentFetchResults(response: response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getCharacterThumbnail(request: Home.GetImage.Request) {
        let request = CustomRequest(url: request.url)

        networking.getData(request: request) { [presenter] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    presenter.presentCharacterThumbnail(response: .init(data: data, url: request.url))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
