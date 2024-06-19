import SwiftUI

struct OrderSheet: View {
    @Environment(\.managedObjectContext) private var moc
    @StateObject var meViewModel = MeViewModel()
    @FetchRequest(sortDescriptors: []) var products: FetchedResults<ProductEntity>
    @State private var showAlert = false
    @State private var alertMessage = ""

    var totalPrice: Double {
        products.reduce(0) { $0 + $1.price * Double($1.amount) }
    }

    var body: some View {
        VStack {
            if let user = meViewModel.user {
                if user.isAnonymous == true {
                    Text("You must Sign Up")
                } else {
                    if let user = meViewModel.user {
                        HStack {
                            Text(user.firstName ?? "Please add your first name.")
                            Text(user.lastName ?? "Please add your last name.")
                        }
                        .padding()
                    }
                    if let user = meViewModel.user {
                        HStack {
                            Text("Your Email")
                                .padding(.horizontal)
                            Spacer()
                            Text(user.email ?? "Please Linked your Google or Gmail account.")
                                .padding(.horizontal)
                        }
                    }
                    if let user = meViewModel.user {
                        HStack {
                            Text("Your Phone")
                                .padding(.horizontal)
                            Spacer()
                            Text(user.phoneNumber ?? "Please Linked your phone number account.")
                                .padding(.horizontal)
                        }
                    }
                    if meViewModel.user != nil {
                        HStack {
                            AddressLine(viewModel: meViewModel, address: meViewModel.user?.address ?? "Please enter your address")
                            Spacer()
                        }
                    }
                }

                VStack {
                    Text("Total price:")
                        .bold()
                        .padding()
                    Text("\(String(format: "%.2f", totalPrice))$")
                }

                List(products) { item in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(item.name ?? "")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("$\(String(format: "%.2f", item.price * Double(item.amount)))")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        HStack {
                            Text(item.selectedColor ?? "")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("x\(item.amount)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        Divider()
                    }
                    .padding(.vertical, 5)
                }

                Spacer()

                Button {
                    orderProducts()
                } label: {
                    Text("Order")
                        .foregroundColor(.primary)
                        .padding()
                        .padding(.horizontal, 40)
                        .clipShape(Capsule())
                        .overlay {
                            Capsule()
                                .stroke(lineWidth: 2)
                                .foregroundColor(.primary)
                        }
                        .background {
                            Capsule()
                                .foregroundColor(.gray)
                        }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Order Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
        .task {
            meViewModel.loadAuthProviders()
            meViewModel.loadAuthUser()
            await meViewModel.checkProviders()
            try? await meViewModel.loadCurrentUser()
        }
    }

    func orderProducts() {
        guard let user = meViewModel.user else { return }

        let productsArray = products.map { product in
            return [
                "id": product.id!.uuidString,
                "name": product.name ?? "",
                "price": product.price,
                "amount": product.amount,
                "selectedColor": product.selectedColor ?? ""
            ] as [String : Any]
        }

        let orderDetails: [String: Any] = [
            "userId": user.userId,
            "firstName": user.firstName ?? "",
            "lastName": user.lastName ?? "",
            "email": user.email ?? "",
            "phoneNumber": user.phoneNumber ?? "",
            "address": user.address ?? "",
            "products": productsArray,
            "totalPrice": totalPrice
        ]

        let url = URL(string: "https://postman-echo.com/post?Content-Type=application/json")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: orderDetails, options: .prettyPrinted)
        } catch {
            print("Failed to serialize JSON: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending POST request: \(error)")
                DispatchQueue.main.async {
                    alertMessage = "Failed to place order: \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }
            guard let data = data else {
                print("No data received in response")
                DispatchQueue.main.async {
                    alertMessage = "No data received in response"
                    showAlert = true
                }
                return
            }
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                print("Server error: \(response.statusCode)")
                DispatchQueue.main.async {
                    alertMessage = "Server error: \(response.statusCode)"
                    showAlert = true
                }
                return
            }
            print("Response: \(String(data: data, encoding: .utf8) ?? "No response body")")

            DispatchQueue.main.async {
                alertMessage = "Order placed successfully!"
                showAlert = true
                deleteAllProducts()
            }
        }
        task.resume()
    }

    func deleteAllProducts() {
        for product in products {
            moc.delete(product)
        }
        do {
            try moc.save()
        } catch {
            print("Failed to delete products: \(error)")
        }
    }
}
