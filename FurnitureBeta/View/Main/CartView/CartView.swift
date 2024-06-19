import SwiftUI
import Kingfisher

struct CartView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var products: FetchedResults<ProductEntity>
    @State private var showingSheet = false
    @State private var isCartEmpty = false

    var body: some View {
        NavigationView {
            VStack {
                if isCartEmpty {
                    Text("Your Cart is empty(")
                } else {
                    cartContentView
                }
            }
            .navigationTitle("Cart")
            .toolbar {
                EditButton()
            }
            .onAppear {
                isCartEmpty = products.isEmpty
            }
            .onChange(of: products.isEmpty) { newValue in
                isCartEmpty = newValue
            }
        }
    }

    private var cartContentView: some View {
        VStack {
            List {
                ForEach(products) { furniture in
                    ProductRowView(furniture: furniture)
                }
                .onDelete(perform: removeRows)
            }

            Button(action: {
                showingSheet = true
            }) {
                Text("Place an Order")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding()
            }
        }
        .sheet(isPresented: $showingSheet) {
            OrderSheet()
        }
    }

    private func removeRows(at offsets: IndexSet) {
        for index in offsets {
            let product = products[index]
            moc.delete(product)
        }
        do {
            try moc.save()
        } catch {
            print("Failed to save changes: \(error)")
        }

        isCartEmpty = products.isEmpty
    }
}
