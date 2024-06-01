import Foundation

struct Product: Codable, Identifiable {
    var id: String
    var name: String
    var price: Double
    var hasDiscount: Bool?
    var discountedPrice: Double?
    var photoForPreview: String?
    var photos: Photos?
    var amount: Int?
    var selectedColor: String?
    var productDetails: [ProductDetails]?
    
    struct ProductDetails: Codable, Hashable {
        var roomType: String
        var color: [String]
        var material: String
        var dimensions: String
        var weight: String
    }
    
    struct Photos: Codable {
        var white: [String]?
        var blue: [String]?
        var red: [String]?
        var brown: [String]?
        var yellow: [String]?
    }
}
