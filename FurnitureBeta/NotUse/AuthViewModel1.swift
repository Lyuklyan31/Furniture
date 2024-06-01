////
////  AuthViewModel.swift
////  FurnitureBeta
////
////  Created by admin on 28.05.2024.
////
//import FirebaseAuth
//import Foundation
//import UIKit
//import SwiftUI
//
//class AuthViewModel: ObservableObject {
//
//    
//    @Published var otpCode: String = ""
//    @Published var email: String = ""
//    @Published var password: String = ""
//    @Published var error: String?
//    @Published var timerIsRunning: Bool = false
//    @Published var gmail: String = "@gmail.com"
//    @Published var phone: String = "+380"
//  
//    @Published var CLIENT_CODE: String = ""
//    @Published var showOTPField: Bool = false
//    
//    @Published var remainingTime: Int = 60
//    var timer: Timer?
//    
//    //MARK: ERROR Properies
//    @Published var showError: Bool = false
//    @Published var errorMassange: String = "false"
//    
//    
//    let model = AuthModel()
//    
//    func signOut() {
//        do {
//            try Auth.auth().signOut()
//            UserDefaults.standard.removeObject(forKey: "uid")
//            self.model.userID = nil
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
//    }
//
//
//    
//    func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            self.timerIsRunning = true
//            if self.remainingTime > 0 {
//                self.remainingTime -= 1
//               
//            } else {
//                self.stopTimer()
//                self.timerIsRunning = false
//                self.remainingTime = 60
//            }
//        }
//    }
//
//    func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    func resetPassword(email: String) async throws {
//        try await Auth.auth().sendPasswordReset(withEmail: email)
//    }
//    
//    
//    func signIn() {
//        model.signIn(email: email, password: password) { error in
//            if let error = error {
//                self.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func signInPhone() {
//        model.signIn(email: phone + gmail, password: password) { error in
//            if let error = error {
//                self.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func signUpPhone() {
//        model.signUp(email: phone + gmail, password: password) { error in
//            if let error = error {
//                self.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func signUp() {
//        model.signUp(email: email, password: password) { error in
//            if let error = error {
//                self.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func isValidPassword(_ password: String) -> Bool {
//        let passwordRegex = NSPredicate(format: "SELF MATCHES %@",
//                                        "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
//        return passwordRegex.evaluate(with: password)
//    }
//    
//    
//    func getOTPCode() {
//        UIApplication.shared.closeKeyboard()
//            Task {
//            do {
//              //MARK: Diasbled it when testing with Real Device
//                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
//                
//               let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(phone)", uiDelegate: nil)
//                await MainActor.run {
//                    CLIENT_CODE = code
//                    
//                    withAnimation(.easeInOut){showOTPField = true}
//                }
//            } catch {
//                await handleError(error: error)
//            }
//        }
//    }
//    
//    
//    
//    func verifyOTPCode() {
//        UIApplication.shared.closeKeyboard()
//        Task {
//            do {
//                let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: otpCode)
//                
//                try await Auth.auth().signIn(with: credential)
//                print("Success!")
//            } catch {
//                await handleError(error: error)
//            }
//        }
//    }
//    
//    
//    
//    //MARK: Hadnding Error
//    func handleError(error: Error) async {
//        await MainActor.run {
//            errorMassange = error.localizedDescription
//            showError.toggle()
//        }
//    }
//    
//    
//   
//}
//
