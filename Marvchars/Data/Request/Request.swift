import Foundation

protocol Request {
    var basePath: String { get }
    var resource: String { get }
    var shouldAddAuthenticationParameters: Bool { get }
}

extension Request {
    var url: URL {
        guard let url = URL(string: "\(basePath)\(resource)") else {
            preconditionFailure("Failed on mount an url with \(resource) resource and : \(basePath) base path.")
        }

        return url
    }
}

protocol MarvelRequest: Request {
}

extension MarvelRequest {
    var basePath: String {
        "https://gateway.marvel.com/"
    }

    var shouldAddAuthenticationParameters: Bool {
        true
    }
}

struct CustomRequest: Request {
    var basePath: String {
        let scheme = url.scheme ?? ""
        let host = url.host ?? ""
        return "\(scheme)s://\(host)"
    }

    var resource: String {
        return url.path
    }

    var url: URL
    var shouldAddAuthenticationParameters: Bool

    init(url: URL, shouldAddAuthenticationParameters: Bool = false) {
        self.url = url
        self.shouldAddAuthenticationParameters = shouldAddAuthenticationParameters
    }
}
