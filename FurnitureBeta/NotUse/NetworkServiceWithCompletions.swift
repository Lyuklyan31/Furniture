
//import Foundation
//
//class NetworkServiceWithCompletions {
//    static let shared = NetworkServiceWithCompletions(); private init() { }
//
//    private func createURL() -> URL? {
//        let url = URL(string: "https://mocki.io/v1/60097594-365a-4bfc-a104-7760e138f9b7")
//        return url
//    }
//    
//    func fetchData(completion: @escaping (Result<CategoryResults, Error>) -> ()) {
//        guard let url = createURL() else {
//            completion(.failure(NetworkingError.badUrl))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data else {
//                if let error {
//                    completion(.failure(error))
//                }
//                return
//            }
//            
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            do {
//                let categoryData = try decoder.decode(CategoryResults.self, from: data)
//                completion(.success(categoryData))
//            } catch {
//                completion(.failure(NetworkingError.invalidData))
//            }
//          
//        }.resume()
//    }
//}
//enum NetworkingError: Error {
//    case badUrl, badRequest, badResponse, invalidData
//}
