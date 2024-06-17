import SwiftUI
import PhotosUI

struct MePersonView: View {
    @ObservedObject var viewModel: MeViewModel
    
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var avatarPickerIsPresented = false
    @State private var url: URL? = nil
   
    var body: some View {
        VStack {
            Button(action: {
                avatarPickerIsPresented = true
            }) {
                if let urlString = viewModel.user?.profileImagePathURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.5)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 3)
                                    .foregroundColor(.primary)
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Circle()
                                            .foregroundColor(.white)
                                            .frame(maxWidth: 35, maxHeight: 35)
                                            .overlay {
                                                Circle()
                                                    .stroke(lineWidth: 2)
                                                    .foregroundColor(.black)
                                                Image(systemName: "pencil")
                                                    .foregroundColor(.blue)
                                                    .font(.title3)
                                            }
                                            .offset(x: 8, y: 12)
                                    }
                                }
                                .padding()
                            }
                    } placeholder: {
                        ProgressView()
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.5)
                    }
                } else {
                    Image(systemName: "person.fill")
                        .foregroundColor(.indigo)
                        .font(.system(size: 100))
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.5)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 3)
                                .foregroundColor(.primary)
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 35, maxHeight: 35)
                                        .overlay {
                                            Circle()
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(.black)
                                            Image(systemName: "pencil")
                                                .foregroundColor(.blue)
                                                .font(.title3)
                                        }
                                        .offset(x: 8, y: 12)
                                }
                            }
                            .padding()
                        }
                }
            }
            .task {
                try? await viewModel.loadCurrentUser()
            }
            .photosPicker(isPresented: $avatarPickerIsPresented, selection: $selectedImage, matching: .images, photoLibrary: .shared())
            .onChange(of: selectedImage) { newValue in
                if let newValue = newValue {
                    viewModel.saveProfileImage(item: newValue)
                }
            }
  
            if viewModel.user?.profileImagePath != nil {
                Button("Delete image") {
                    viewModel.deleteProfileImage()
                }
            }
        }
    }
}

