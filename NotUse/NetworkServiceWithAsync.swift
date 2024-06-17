
//import Foundation
////NetworkServiceWithAsync
//final class NetworkService {
//    
//    static let shared = NetworkService()
//    
//    private init() { }
//    
//    private func createURL() -> URL? {
//        let url = URL(string: "https://mocki.io/v1/69a8e234-8923-43d6-b607-1fa9d8a48033")
//        return url
//    }
//    
//    func fetchData() async throws -> CategoryResults {
//        guard let url = createURL() else { throw NetworkingError.badUrl }
//        
//        let response = try await URLSession.shared.data(from: url)
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        let result = try decoder.decode(CategoryResults.self, from: response.0)
//        return result
//    }
//}
//
//enum NetworkingError: Error {
//    case badUrl, badRequest, badResponse, invalidData
//}
