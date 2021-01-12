import Foundation

final class WebClient: Networking {
    private func getAuthenticationParameters() -> [String: String] {
        let timestamp = Date().timeIntervalSince1970
        let privateKey = "9ce3c8e3959c3003e5f71439cf855c5a2467f0ef"
        let publicKey = "527627481b0a475ae10601b7c35add86"

        guard let hash = MD5.hash(from: "\(timestamp)\(privateKey)\(publicKey)") else {
            preconditionFailure("Failure on generating hash")
        }

        return [
            "apikey": publicKey,
            "ts": "\(timestamp)",
            "hash": hash
        ]
    }

    func fetch<T: Decodable>(request: Request, completion: @escaping (Result<T, Error>) -> Void) {
        getData(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()

                    decoder.dateDecodingStrategy = .iso8601

                    let payload = try decoder.decode(T.self, from: data)

                    completion(.success(payload))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getData(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        var url = request.url

        if request.shouldAddAuthenticationParameters {
            url.append(parameters: getAuthenticationParameters())
        }

        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                preconditionFailure("Data not provided")
            }

            completion(.success(data))
        }.resume()
    }
}
