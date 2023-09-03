//
//  AuthenticationModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 20/08/23.
//

import Foundation

struct ResponseSignUpFailed: Codable {
  let status: String
  let isError: Bool
  let descriptionKey: String
  
  enum CodingKeys: String, CodingKey{
    case status
    case isError
    case descriptionKey = "description"
  }
}

struct ResponseSignUpSuccess: Codable {
  let status: String
  let isError : Bool
  let data: Success
}

struct Success: Codable {
  let id: Int
  let fullName, username, email: String
  let createdAt, updatedAt: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case fullName = "full_name"
    case username, email
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}

struct LoginFailed: Codable {
  let status: String
  let isError: Bool
  let descriptionKey: String
  
  enum CodingKeys: String, CodingKey{
    case status
    case isError
    case descriptionKey = "description"
  }
}

struct LoginSuccess: Codable {
  let status: String
  let isError: Bool
  let data: LoginValid
}

struct LoginValid: Codable {
  let access_token: String
  let refresh_token: String
}

struct ResendEmailFailed: Codable {
  let status: String
  let isError: Bool
  let descriptionKey: String
  
  enum CodingKeys: String, CodingKey {
    case status
    case isError
    case descriptionKey = "description"
  }
}

struct ResendEmailSucces: Codable {
  let status: String
  let isError: Bool
  let data: Message
}

struct Message: Codable {
  let message: String
}

struct ForgetPasswordSuccess: Codable {
  let status: String
  let isError: Bool
  let data: Message
  
}

struct ForgetPasswordFailed: Codable {
  let status: String
  let isError: Bool
  let descriptionKey: String
  
  enum CodingKeys: String, CodingKey {
    case status
    case isError
    case descriptionKey = "description"
  }
}

struct VerificationCodeSuccess: Codable {
  let status: String
  let isError: Bool
  let data: Message
}

struct VerificationCodeFailed: Codable {
  let status: String
  let isError: Bool
  let descriptionKey: String
  
  enum CodingKeys: String, CodingKey {
    case status
    case isError
    case descriptionKey = "description"
  }
}

struct ResetPasswordSucces: Codable {
  let status: String
  let isError: Bool
  let data: Message
}

struct ResetPasswordFailed: Codable {
  let status: String
  let isError: Bool
  let descriptionKey: String
  
  enum CodingKeys: String, CodingKey {
    case status
    case isError
    case descriptionKey = "description"
  }
}
