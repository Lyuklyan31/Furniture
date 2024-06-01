

//import Foundation
//
//class CartModel: ObservableObject {
//    let saveKey = "Furnitures"
//    @Published var furnitures = [CategoryResults.Store.Category.Product]()
//    init() {
//        if let savedFurnitures = UserDefaults.standard.data(forKey: saveKey) {
//            if let decodedFurnitures = try? JSONDecoder().decode([CategoryResults.Store.Category.Product].self, from: savedFurnitures) {
//                furnitures = decodedFurnitures
//                return
//            }
//        }
//        furnitures = []
//    }
//    
//    func save() {
//        if let encoded = try? JSONEncoder().encode(furnitures) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
//    }
//    
//    func add(_ furniture: CategoryResults.Store.Category.Product) {
//        if let existingIndex = furnitures.firstIndex(where: { $0.name == furniture.name && $0.selectedColor == furniture.selectedColor }) {
//            furnitures[existingIndex].amount! += furniture.amount ?? 1
//        } else {
//            furnitures.append(furniture)
//        }
//        save()
//    }
//}
