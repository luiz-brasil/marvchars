import UIKit

protocol HomeDisplayLogic {
    func didFetchItems(with viewModel: Home.Fetch.ViewModel)
    func didGetCaracterThumbnail(with viewModel: Home.GetImage.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    private var characters: [AnyObject] = []
    private var interactorIfLoaded: HomeViewInteractor?

    private var interactor: HomeViewInteractor {
        guard let interactor = interactorIfLoaded else {
            preconditionFailure("Interactor not loaded")
        }

        return interactor
    }

    private var viewTyped: HomeView {
        guard let view = self.view as? HomeView else {
            preconditionFailure("viewTyped should be of HomeView type.")
        }

        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewTyped.render()

        prepareUI()

        interactor.fetchItems(request: .init())
    }

    override func loadView() {
        let view = HomeView()

        view.delegate = self

        self.view = view
    }

    private func prepareUI() {
        title = "Characters"
        tabBarItem = .init(tabBarSystemItem: .mostViewed, tag: 0)
    }

    func inject(interactor: HomeViewInteractor) {
        interactorIfLoaded = interactor
    }

    func didFetchItems(with viewModel: Home.Fetch.ViewModel) {
        viewTyped.update(characters: viewModel.characters)
    }

    func didGetCaracterThumbnail(with viewModel: Home.GetImage.ViewModel) {
        viewTyped.update(at: viewModel.url, characterThumbnail: viewModel.image)
    }
}

extension HomeViewController: HomeViewDelegate {
    func view(_ view: UIView, loadThumbnailAt url: URL) {
        interactor.getCharacterThumbnail(request: .init(url: url))
    }
}
