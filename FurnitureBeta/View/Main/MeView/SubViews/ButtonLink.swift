import SwiftUI

struct ButtonLink: View {
    @ObservedObject var viewModel: MeViewModel
    var buttonName: String
    var customImageName: String?
    var systemImageName: String?
    var isLinked: Bool
    @State private var showEmailSheet: Bool = false
    @State private var showPhoneSheet: Bool = false
    let action: () async throws -> Void

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button {
            if buttonName == "Link Email Account" {
                showEmailSheet = true
            }
            if buttonName == "Link Phone Account" {
                showPhoneSheet = true
            }
            
            Task {
                do {
                    try await action()
                } catch {
                    print(error)
                }
            }
        } label: {
            HStack {
                Text(isLinked ?  "Linked" : buttonName)
                    .bold()
                    .foregroundColor(.primary)
                
                if let systemImageName = systemImageName {
                    Image(systemName: systemImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20, maxHeight: 20)
                        .foregroundColor(.primary)
                } else if let customImageName = customImageName {
                    Image(customImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20, maxHeight: 20)
                }
                
                if isLinked {
                    Image(systemName: "checkmark.circle")
                        .bold()
                        .foregroundColor(.green)
                }
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .overlay {
                Capsule()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)
        }
        .disabled(isLinked)
        .sheet(isPresented: $showEmailSheet, content: {
            LinkEmail(viewModel: viewModel)
                .presentationDetents([.fraction(0.4)])
        })
        .sheet(isPresented: $showPhoneSheet, content: {
            LinkPhone(viewModel: viewModel)
                .presentationDetents([.fraction(0.4)])
        })
    }
}
