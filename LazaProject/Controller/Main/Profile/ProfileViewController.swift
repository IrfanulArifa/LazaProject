//
//  ProfileViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 21/08/23.
//

import UIKit
import SDWebImage

class ProfileViewController: ViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  let imagePicker = UIImagePickerController()
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var nameUser: UILabel!
  @IBOutlet weak var usernameUser: UILabel!
  @IBOutlet weak var emailUser: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let data = UserDefaults.standard
    nameUser.text = data.string(forKey: "name")
    usernameUser.text = data.string(forKey: "username")
    emailUser.text = data.string(forKey: "email")
    
    imagePicker.delegate = self
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    
    if let selectedImage = info[.originalImage] as? UIImage {
      // Lakukan sesuatu dengan gambar yang dipilih
      // Misalnya, tampilkan di UIImageView
      profileImage.image = selectedImage
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func cameraClicked(_ sender: Any) {
    showImagePicker()
  }
  
  func showImagePicker() {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true)
  }
}
