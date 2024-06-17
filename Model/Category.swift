import Foundation

struct Category: Codable, Identifiable {
    var id: String
    var name: String
    var photo: String?
    var product: Product?
}
