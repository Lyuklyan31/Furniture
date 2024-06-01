import Foundation
import FirebaseAuth

class AuthennticatedUser: ObservableObject {
    @Published var userID: String? = UserDefaults.standard.string(forKey: "uid")
    
    static let shared = AuthennticatedUser()
    private init() { } 
    
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let authResult = authResult {
                self.userID = authResult.user.uid
                UserDefaults.standard.set(authResult.user.uid, forKey: "uid")
            }
            completion(error)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let authResult = authResult {
                self.userID = authResult.user.uid
                UserDefaults.standard.set(authResult.user.uid, forKey: "uid")
            }
            completion(error)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "uid")
            self.userID = nil
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
