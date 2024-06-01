import SwiftUI

class DataViewModel: ObservableObject {
    @Published var promotions = [Promotions]()
    @Published var special = [Special]()
    @Published var products = [Product]()
    @Published var category = [Category]()
    
    init() {
        Task {
           await loadData()
        }
    }
    
    func loadData() async {
        do {
            let promotions: [Promotions] = try await NetworkService.shared.fetchData(from: .promotions)
            let special: [Special] = try await NetworkService.shared.fetchData(from: .special)
            let products: [Product] = try await NetworkService.shared.fetchData(from: .product)
            let category: [Category] = try await NetworkService.shared.fetchData(from: .category)
            
            DispatchQueue.main.async { [weak self] in
                self?.promotions = promotions
                self?.special = special
                self?.products = products
                self?.category = category
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
