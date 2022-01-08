
import Foundation

// MARK: - RequestError
struct RequestError: Codable {
    let statusCode: Int
    let error: String
    let message, data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id, message: String
}

/*
 Request Errors that may occur when "SignIn".
    - 1. Identifier or password invalid.
    - 2. Please provide your username or your e-mail.
    - 3. Please provide your password.
 */

/*
 Request Errors that may occur when "SignUp".
    - 1. Email is already taken.
    - 2. Please provide valid email address.
    - 3. Please provide your password.
 */




