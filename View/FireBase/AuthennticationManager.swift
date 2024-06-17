import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let phoneNumber: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.phoneNumber = user.phoneNumber
    }
}


enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
    case phoneNumber = "phone"
}

class AuthennticationManager: ObservableObject {
    
   
    @Published var userID: String? = UserDefaults.standard.string(forKey: "uid")
    
    static let shared = AuthennticationManager()
    private init() { }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    
    //MARK: - GET PROVIDER
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        
        var providers: [AuthProviderOption] = []
        
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
    
    
    func signOut() throws {
        try Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "uid")
        self.userID = nil
    }
   
    func delete() async throws {
        guard let user = Auth.auth().currentUser  else {
            throw URLError(.badURL)
        }
        try await user.delete()
        UserDefaults.standard.removeObject(forKey: "uid")
        self.userID = nil
    }
}

//MARK: - EMAIL/SignIn/SignUp/SignOut/RessetPassword/UpdatePassword/UpdateEmail
extension AuthennticationManager {
    
    @discardableResult
     func createUser(email: String, password: String) async throws -> AuthDataResultModel {
         let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
         try await authDataResult.user.sendEmailVerification()
         return AuthDataResultModel(user: authDataResult.user)
       
     }
     
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        let userID = authDataResult.user.uid
        UserDefaults.standard.set(userID, forKey: "uid")
        
        return AuthDataResultModel(user: authDataResult.user)
    }

     
     func updatePassword(password: String) async throws {
         guard let user = Auth.auth().currentUser else {
             throw URLError(.badServerResponse)
         }
         try await user.updatePassword(to: password)
     }
     
     func updateEmail(email: String) async throws {
         guard let user = Auth.auth().currentUser else {
             throw URLError(.badServerResponse)
         }
         try await user.sendEmailVerification(beforeUpdatingEmail: email)
     }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}

//MARK: - SIGN IN GOOGLE/ SIGN IN APPLE
extension AuthennticationManager {
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        let authDataResult = try await signIn(credential: credential)
        UserDefaults.standard.set(authDataResult.uid, forKey: "uid")
        userID = authDataResult.uid
        
        return authDataResult
    }
    
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        let authDataResult = try await signIn(credential: credential)
        UserDefaults.standard.set(authDataResult.uid, forKey: "uid")
        userID = authDataResult.uid
        
        return authDataResult
    }
    
        func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
            let authDataResult = try await Auth.auth().signIn(with: credential)
            return AuthDataResultModel(user: authDataResult.user)
    }
}


//MARK: - SIGN IN ANONYMOUS


extension AuthennticationManager {
    
    @discardableResult
    func signInAnonymous() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
        let userID = authDataResult.user.uid
        UserDefaults.standard.set(userID, forKey: "uid")
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func linkEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        return try await linkCredential(credential: credential)
    }
    
    func linkPhone(verificationID: String, verificationCODE: String) async throws -> AuthDataResultModel {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCODE)
        return try await linkCredential(credential: credential)
    }
    
    func linkGoogle(tokens: GoogleSignResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await linkCredential(credential: credential)
    }
    
    func linkApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue,  idToken: tokens.token,   rawNonce: tokens.nonce)
        return try await linkCredential(credential: credential)
    }
    
    private func linkCredential(credential: AuthCredential) async throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        let authDataResult = try await user.link(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}

//MARK: - Sign IN WITH PHONE

extension AuthennticationManager {
    @discardableResult
    func signInWithPhone(verificationID: String, verificationCODE: String) async throws -> AuthDataResultModel {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCODE)
        let authDataResult = try await Auth.auth().signIn(with: credential)
        let userID = authDataResult.user.uid
        UserDefaults.standard.set(userID, forKey: "uid")
        
        return AuthDataResultModel(user: authDataResult.user)
    }
}
