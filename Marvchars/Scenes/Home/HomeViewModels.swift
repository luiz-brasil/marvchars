import Foundation
import UIKit

struct Home {
    struct Fetch {
        struct Request {
        }

        struct Response {
            struct Character {
                let name: String
                let picture: URL
            }

            let characters: [Character]
        }

        struct ViewModel {
            struct Character {
                let name: String
                let pictureUrl: URL
            }

            let characters: [Character]
        }
    }

    struct GetImage {
        struct Request {
            let url: URL
        }

        struct Response {
            let data: Data
            let url: URL
        }

        struct ViewModel {
            let image: UIImage
            let url: URL
        }
    }
}
