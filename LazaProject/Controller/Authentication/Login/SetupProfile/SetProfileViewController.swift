//
//  SetProfileViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 02/09/23.
//

import UIKit

class SetProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  let imagePicker = UIImagePickerController()
  let viewModel = UpdateProfileViewModel()
  
  @IBOutlet weak var setProfileTitle: UILabel!{
    didSet {
      setProfileTitle.font = UIFont(name: "Poppins-SemiBold", size: 20)
    }
  }
  @IBOutlet weak var subTitle: UILabel!{
    didSet {
      subTitle.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var fullnameTxt: UILabel!{
    didSet {
      fullnameTxt.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var fullnameTxtField: UITextField!{
    didSet {
      fullnameTxtField.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var validFullName: UIImageView!{
    didSet {
      validFullName.isHidden = true
    }
  }
  
  @IBOutlet weak var skipTapped: UIButton!{
    didSet {
      skipTapped.layer.borderWidth = 1.0
      skipTapped.layer.borderColor = UIColor.white.cgColor
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: true)
    fullnameTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    imagePicker.delegate = self
    forgetToSave()
  }
  
  @objc private func checkValidation() {
    let isValidFullname = (fullnameTxtField.text ?? "").count > 6
    if isValidFullname {
      validFullName.isHidden = false
    } else {
      validFullName.isHidden = true
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    
    if let selectedImage = info[.originalImage] as? UIImage {
      profileImage.image = selectedImage
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func showImagePicker() {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true)
  }
  
  func goToHome() {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    self.view.window?.windowScene?.keyWindow?.rootViewController = vc
  }
  
  private func forgetToSave() {
    let token = UserDefaults.standard.string(forKey: "access_token")
    let username = UserDefaults.standard.string(forKey: "username")
    let email = UserDefaults.standard.string(forKey: "email")
    if fullnameTxtField.text != "" {
      viewModel.updateProfile(image: profileImage.image!, token: token!, fullname: fullnameTxtField.text!, username: username!, email: email!) { response in
      } onError: { error in
        DispatchQueue.main.async {
          self.showAlert(title: "Failed", message: error.capitalized)
        }
      }

    } else {
      viewModel.updateProfile(image: profileImage.image!, token: token!, fullname: username!, username: username!, email: email!) { response in
      } onError: { error in
        DispatchQueue.main.async {
          self.showAlert(title: "Failed", message: error.capitalized)
        }
      }
    }
  }
  
  private func saveDummy() {
    let token = UserDefaults.standard.string(forKey: "access_token")
    let username = UserDefaults.standard.string(forKey: "username")
    let email = UserDefaults.standard.string(forKey: "email")
    if fullnameTxtField.text != "" {
      viewModel.updateProfile(image: profileImage.image!, token: token!, fullname: fullnameTxtField.text!, username: username!, email: email!) { response in
        DispatchQueue.main.async {
          self.goToHome()
        }
      } onError: { error in
        DispatchQueue.main.async {
          self.showAlert(title: "Failed", message: error.capitalized)
        }
      }

    } else {
      viewModel.updateProfile(image: profileImage.image!, token: token!, fullname: username!, username: username!, email: email!) { response in
        DispatchQueue.main.async {
          self.goToHome()
        }
      } onError: { error in
        DispatchQueue.main.async {
          self.showAlert(title: "Failed", message: error.capitalized)
        }
      }
    }
  }
  
  @IBAction func cameraTapped(_ sender: UIButton) {
    showImagePicker()
  }
  
  @IBAction func saveTapped(_ sender: UIButton) {
    let token = UserDefaults.standard.string(forKey: "access_token")
    let username = UserDefaults.standard.string(forKey: "username")
    let email = UserDefaults.standard.string(forKey: "email")
    if fullnameTxtField.text != "" {
      viewModel.updateProfile(image: profileImage.image!, token: token!, fullname: fullnameTxtField.text!, username: username!, email: email!) { response in
        DispatchQueue.main.async { [unowned self] in
          self.goToHome()
        }
      } onError: { error in
        DispatchQueue.main.async { [unowned self] in
          self.showAlert(title: "Failed", message: error.capitalized)
        }
      }
    } else {
      invalidSnackBar.make(in: self.view, message: "Fullname Field is Empty", duration: .lengthLong).show()
    }
  }
  
  @IBAction func skipTapped(_ sender: UIButton) {
    saveDummy()
  }
}
