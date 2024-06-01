

import Foundation
import Firebase

class FirebaseManager: ObservableObject {
    @Published var userIsLoggedIn = false
    @Published var errorMessage: String?
    
    func registNewUser(user: UserData) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            guard error == nil else {
                self.errorMessage = error?.localizedDescription
                return
            }
            result?.user.sendEmailVerification()
            
            if let uid = result?.user.uid {
                Firestore.firestore()
                    .collection("users")
                    .document(uid)
                    .setData(["name": user.name,"email": user.email, "registrationDate": Timestamp(date: Date())], merge: true)
            }
        }
    }
    
//    func registerNewUserPhone(user: UserData) {
//        PhoneAuthProvider
//    }
    
    func login(user: UserData) {
        Auth.auth().signIn(withEmail: user.email,password: user.password) { result, error in
            guard error == nil else {
                self.errorMessage = error?.localizedDescription
                return
            }
            self.userIsLoggedIn = true
        }
    }
    
    func checkCurrentUser() {
            if Auth.auth().currentUser != nil {
                self.userIsLoggedIn = true
            } else {
                self.userIsLoggedIn = false
            }
        }
}
