import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() { }
    
    func fetchData<T: Decodable>(from endpoint: EndPoints) async throws -> T {
        guard let url = URLManager.shared.createUrl(endPoint: endpoint, id: nil) else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
           
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error fetching or decoding data: \(error)")
            throw error
        }
    }
}
    

extension NetworkService {
    
    func loadData<T: Decodable>(from endpoint: EndPoints, into array: inout [T]) async {
        do {
            let data: [T] = try await NetworkService.shared.fetchData(from: endpoint)
            array = data
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
