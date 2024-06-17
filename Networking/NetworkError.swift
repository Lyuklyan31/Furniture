enum NetworkError: Error {
    case badURL
    case badResponse
    case decodingError
    case unauthorized
    case forbidden
    case notFound
}
