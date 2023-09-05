//
//  Endpoint.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 05/09/23.
//

import Foundation

class Endpoint {
  
  static func APIAddress() -> String {
    let baseUrl = "https://lazaapp.shop/"
    return baseUrl
  }
  
  enum Path: String {
    case login = "login"
    case profil = "user/profile"
    case register = "register"
    case forgotPassword = "auth/forgotpassword"
    case verify = "auth/confirm/resend"
    case verification = "auth/recover/code"
    case resetPassword = "auth/recover/password"
  }
  
  enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
  }
  
  enum HTTPHeader: String {
    case XAuthToken = "X-Auth-Token"
    case XAuthRefresh = "X-Auth-Refresh"
  }
}
