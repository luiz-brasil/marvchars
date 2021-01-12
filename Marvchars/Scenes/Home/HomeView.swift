import UIKit

protocol HomeViewDelegate: AnyObject {
    func view(_ view: UIView, loadThumbnailAt url: URL)
}

final class HomeView: UIView {
    private var characters: [Home.Fetch.ViewModel.Character]?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        layout.sectionInsetReference = .fromSafeArea

        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    weak var delegate: HomeViewDelegate?

    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    private func prepareUI() {
        backgroundColor = .init(white: 1, alpha: 0)

        configureControls()
    }

    private func configureControls() {
        configureCollectionView()
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }

        addSubview(collectionView)

        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CharacterCollectionViewCell.self))

        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }

    func update(characters: [Home.Fetch.ViewModel.Character]) {
        self.characters = characters

        collectionView.reloadData()
    }

    func render() {
        prepareUI()
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell,
              let characters = self.characters else {
            return UICollectionViewCell()
        }

        cell.dataSource = self
        cell.update(characters[indexPath.row])

        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 100
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right

        return CGSize(width: referenceWidth, height: referenceHeight)
    }

    func update(at url: URL, characterThumbnail: UIImage) {
        guard let characters = self.characters,
              let characterIndex = characters.firstIndex(where: { $0.pictureUrl == url }),
              let cell = collectionView.cellForItem(at: .init(row: characterIndex, section: 0)) as? CharacterCollectionViewCell else {
            return
        }

        cell.updateThumbnail(with: characterThumbnail)
    }
}

extension HomeView: CharacterCollectionViewCellDataSource {
    func characterCollectionViewCell(imageForCharacterUrl url: URL) {
        delegate?.view(self, loadThumbnailAt: url)
    }
}
