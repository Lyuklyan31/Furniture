

import Foundation
import FirebaseAuth

//struct PhoneAuthResultModel {
//    let verificationID: String
//    let verificationCODE: String
//    let phoneNumber: String
//}

//final class PhoneAuthHelperr: ObservableObject {
//    @MainActor
//    func sendVerificationCode(phoneNumber: String) async throws -> PhoneAuthResultModel {
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                
//                guard let verificationID = verificationID else {
//                    continuation.resume(throwing: URLError(.badServerResponse))
//                    return
//                }
//                
//                let result = PhoneAuthResultModel(verificationID: verificationID, verificationCODE: "", phoneNumber: phoneNumber)
//                continuation.resume(returning: result)
//            }
//        }
//    }
//    
//}

