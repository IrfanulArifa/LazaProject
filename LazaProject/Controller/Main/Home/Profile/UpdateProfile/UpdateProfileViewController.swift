//
//  ProfileViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 21/08/23.
//

import UIKit
import SDWebImage

class UpdateProfileViewController: ViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  let imagePicker = UIImagePickerController()
  let viewModel = UpdateProfileViewModel()
  
  @IBOutlet weak var updateProfile: UILabel!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var profileImage: UIImageView!
  
  // MARK: TextField
  @IBOutlet weak var fullName: UITextField!
  @IBOutlet weak var userName: UITextField!
  @IBOutlet weak var emailAddress: UITextField!
  
  @IBOutlet weak var disableView: UIView!{
    didSet {
      disableView.isHidden = true
    }
  }
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet {
      indicatorLoading.isHidden = true
    }
  }
  
  
  // MARK: ChecklistValidation
  @IBOutlet weak var fullnameCheck: UIImageView!{
    didSet {
      fullnameCheck.isHidden = true
    }
  }
  
  @IBOutlet weak var usernameCheck: UIImageView!
  @IBOutlet weak var emailCheck: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let data = UserDefaults.standard
    fullName.text = data.string(forKey: "fullname")
    userName.text = data.string(forKey: "username")
    emailAddress.text = data.string(forKey: "email")
    profileImage.sd_setImage(with: URL(string: data.string(forKey: "image") ?? ""))
    self.tabBarController?.tabBar.isHidden = true
    
    fullName.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    userName.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    emailAddress.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    
    imagePicker.delegate = self
  }
  
  func startingAnimation() {
    self.indicatorLoading.startAnimating()
    self.indicatorLoading.isHidden = false
    self.disableView.isHidden = false
  }
  
  func hidingAnimation() {
    self.indicatorLoading.stopAnimating()
    self.indicatorLoading.isHidden = true
    self.disableView.isHidden = true
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    
    if let selectedImage = info[.originalImage] as? UIImage {
      profileImage.image = selectedImage
    }
  }
  
  @objc private func checkValidation() {
    let isValidEmail = emailAddress.validEmail(emailAddress.text ?? "")
    let isValidUsername = (userName.text ?? "").count > 6
    let isValidFullname = (fullName.text ?? "").count > 6
    
    if isValidEmail {
      emailCheck.isHidden = false
    } else if !isValidEmail {
      emailCheck.isHidden = true
    }
    
    if isValidFullname {
      fullnameCheck.isHidden = false
    } else if !isValidFullname {
      fullnameCheck.isHidden = true
    }
    
    if isValidUsername {
      usernameCheck.isHidden = false
    } else if !isValidUsername {
      usernameCheck.isHidden = true
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
  
  @IBAction func backButton(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
  @IBAction func updateProfileClicked(_ sender: UIButton) {
    startingAnimation()
    let token = UserDefaults.standard.string(forKey: "access_token")
    viewModel.updateProfile(image: profileImage.image!, token: token!, fullname: fullName.text!, username: userName.text!, email: emailAddress.text!) { response in
      DispatchQueue.main.async {
        self.hidingAnimation()
        self.showAlert(title: "Success", message: "Update Image Success \n Return to Profile Page"){
          self.dismiss(animated: true)
        }
      }
    } onError: { error in
      DispatchQueue.main.async {
        self.hidingAnimation()
        self.showAlert(title: "Failed", message: error.capitalized)
      }
    }
  }
}
