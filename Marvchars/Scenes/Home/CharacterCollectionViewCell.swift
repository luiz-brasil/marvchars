import UIKit

protocol CharacterCollectionViewCellDataSource: AnyObject {
    func characterCollectionViewCell(imageForCharacterUrl url: URL)
}

final class CharacterCollectionViewCell: UICollectionViewCell {
    private lazy var thumbnailImageView: UIImageView = {
        let element = UIImageView()

        element.contentMode = .scaleToFill

        element.translatesAutoresizingMaskIntoConstraints = false

        return element
    }()

    private lazy var name: UILabel = {
        UILabel()
    }()

    private lazy var favorite: UIButton = {
        UIButton()
    }()

    weak var dataSource: CharacterCollectionViewCellDataSource?

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

    private func prepareUI() {
        prepareConstraints()
    }

    private func prepareConstraints() {
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 2 - 24).isActive = true

        contentView.addSubview(thumbnailImageView)

        NSLayoutConstraint.activate(
            [
                thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ]
        )
    }

    func update(_ character: Home.Fetch.ViewModel.Character) {
        name.text = character.name

        dataSource?.characterCollectionViewCell(imageForCharacterUrl: character.pictureUrl)
    }

    func updateThumbnail(with image: UIImage) {
        self.thumbnailImageView.image = image
    }
}
