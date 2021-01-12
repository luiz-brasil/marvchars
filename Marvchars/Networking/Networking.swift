import Foundation

protocol Networking {
    func fetch<T: Decodable>(request: Request, completion: @escaping (Result<T, Error>) -> Void)
    func getData(request: Request, completion: @escaping (Result<Data, Error>) -> Void)
}
