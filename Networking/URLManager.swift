
import Foundation

class URLManager {
    static let shared = URLManager()
    private init() { }
    
    private var tunnel = "https://"
    private let server = "mocki.io/v1"
    
    func createUrl(endPoint: EndPoints, id: Int?) -> URL? {
        var str = tunnel + server + endPoint.rawValue
        if let id {
            str += "/\(id)"
        }
        let url = URL(string: str)
        return url
        
    }
}

