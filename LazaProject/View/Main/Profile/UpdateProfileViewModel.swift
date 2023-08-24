//
//  UpdateProfileViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 23/08/23.
//

import UIKit

class UpdateProfileViewModel {
  func updateProfile(image: UIImage,
                     token: String,
                     fullname: String,
                     username: String,
                     email: String,
                     completion: @escaping ((UserSuccess?)-> Void),
                     onError: @escaping (String)-> Void) {
    let decoder = JSONDecoder()
    let url = URL(string: "http://lazaapp.shop/user/update")!
    guard let mediaImage = Media(withImage: image, forKey: "image") else {
      print("Media Creation Failed")
      return }
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    
    let boundary = generateBoundary()
    
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)", forHTTPHeaderField: "X-Auth-Token")
    
    let parameters = [
      "full_name": fullname,
      "username":username,
      "email": email,
    ]
    
    let dataBody = createDataBody(withParameters: parameters, media: mediaImage, boundary: boundary)
    request.httpBody = dataBody
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        completion(nil)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else { return }
      
      guard let data = data else {
        print("Tidak ada data yang diterima")
        return
      }
      
      if httpResponse.statusCode != 200 {
        guard let failedModel = try? decoder.decode(VerificationCodeFailed.self, from: data) else {
          onError("Verification Failed - Failed to Decode")
          return
        }
        do {
          let result = try decoder.decode(UserSuccess.self, from: data)
          ViewModel().updateProfil(token: token, fullname: fullname, username: username, email: email, image: result.imageURL)
          completion(result)
        } catch {
          print("Error Decoding JSON response: \(error)")
        }
      }
    }
    task.resume()
  }
  
  func createDataBody(withParameters params: Parameters?, media: Media?, boundary: String) -> Data {
    let lineBreak = "\r\n"
    var body = Data()
    if let parameters = params {
      for (key, value) in parameters {
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
        body.append("\(value + lineBreak)")
      }
    }
    if let media = media {
      body.append("--\(boundary + lineBreak)")
      body.append("Content-Disposition: form-data; name=\"\(media.key)\"; filename=\"\(media.filename)\"\(lineBreak)")
      body.append("Content-Type: \(media.mimeType + lineBreak + lineBreak)")
      body.append(media.data)
      body.append(lineBreak)
    }
    body.append("--\(boundary)--\(lineBreak)")
    return body
  }
  
  func generateBoundary() -> String {
    return "Boundary-\(NSUUID().uuidString)"
  }
}


extension Data {
  mutating func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      append(data)
    }
  }
}
