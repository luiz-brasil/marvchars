import Foundation

extension URL {
    mutating func append(_ item: URLQueryItem) {
        guard var components = URLComponents(string: absoluteString) else {
            return
        }

        var queryItems: [URLQueryItem] = components.queryItems ?? []

        queryItems.append(item)

        components.queryItems = queryItems

        guard let url = components.url else {
            return
        }

        self = url
    }

    mutating func append(parameters: [String: String]) {
        parameters.forEach { parameter in
            self.append(URLQueryItem(name: parameter.key, value: parameter.value))
        }
    }
}
