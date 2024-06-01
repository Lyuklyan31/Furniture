import Foundation
import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var otpCode: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var gmail: String = "@gmail.com"
    @Published var phone: String = "+380"
    @Published var forgotPassword: String = ""
    @Published var showForgotPassword = false
    
    @Published var CLIENT_CODE: String = ""
    @Published var showOTPField: Bool = false
    
    @Published var timerIsRunning: Bool = false
    @Published var remainingTime: Int = 60
    
    @Published var error: String?
    @Published var showError: Bool = false
    @Published var errorMassange: String = "false"
    
    var timer: Timer?

    func signOut() {
        AuthennticatedUser.shared.signOut()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timerIsRunning = true
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stopTimer()
                self.timerIsRunning = false
                self.remainingTime = 60
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func resetPasswordEmail() async throws {
     try await AuthennticatedUser.shared.resetPassword(email: forgotPassword)
    }
    
    
    
    func signIn() {
        AuthennticatedUser.shared.signIn(email: email, password: password) { error in
            if let error = error {
                self.error = error.localizedDescription
            }
        }
    }

    func signInPhone() {
        AuthennticatedUser.shared.signIn(email: phone + gmail, password: password) { error in
            if let error = error {
                self.error = error.localizedDescription
            }
        }
    }

    func signUpPhone() {
        AuthennticatedUser.shared.signUp(email: phone + gmail, password: password) { error in
            if let error = error {
                self.error = error.localizedDescription
            }
        }
    }

    func signUp() {
        AuthennticatedUser.shared.signUp(email: email, password: password) { error in
            if let error = error {
                self.error = error.localizedDescription
            }
        }
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@",
                                        "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return passwordRegex.evaluate(with: password)
    }

    func getOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(phone)", uiDelegate: nil)
                await MainActor.run {
                    CLIENT_CODE = code
                    withAnimation(.easeInOut) { showOTPField = true }
                }
            } catch {
                await handleError(error: error)
            }
        }
    }

    func verifyOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: otpCode)
                try await Auth.auth().signIn(with: credential)
                print("Success!")
            } catch {
                await handleError(error: error)
            }
        }
    }

    func handleError(error: Error) async {
        await MainActor.run {
            errorMassange = error.localizedDescription
            showError.toggle()
        }
    }
}
