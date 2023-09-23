/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Le Minh Quan, Dinh Huu Gia Phuoc, Vu Gia An, Trieu Hoang Khang, Nguyen Tran Khang Duy
  ID: s3877969, s3878270, s3926888, s3878466, s3836280
  Created  date: 10/9/2023
  Last modified: 23/9/2023
  Acknowledgement:
https://rmit.instructure.com/courses/121597/pages/w9-whats-happening-this-week?module_item_id=5219569
https://rmit.instructure.com/courses/121597/pages/w10-whats-happening-this-week?module_item_id=5219571
*/


import Foundation
import SwiftUI
import FacebookLogin
import FacebookCore
import Firebase

final class FacebookSignInHelper: ObservableObject {
    private let loginManager = LoginManager()
    
    func loginFacebook() async throws -> FacebookLoginResult {
        return await withCheckedContinuation { continuation in
            loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                if let error = error {
                    continuation.resume(returning: .error(error))
                } else if let result = result, !result.isCancelled {
                    Task {
                        do {
                            let authDataResult = try await AuthenticationManager.instance.signInWithFacebook(token: AccessToken.current!.tokenString)
                            let user = DBUser(auth: authDataResult)
                            try await UserManager.instance.createNewUser(user: user)
                            print("Logged in with Facebook")
                            continuation.resume(returning: .success) // Success
                        } catch {
                            print(error)
                            continuation.resume(returning: .error(error)) // Error
                        }
                    }
                } else {
                    continuation.resume(returning: .cancelled) // Cancelled
                }
            }
        }
    }
}

enum FacebookLoginResult {
    case success
    case error(Error)
    case cancelled
}
