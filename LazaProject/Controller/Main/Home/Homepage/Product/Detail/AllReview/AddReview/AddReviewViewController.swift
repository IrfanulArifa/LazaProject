//
//  AddReviewViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 03/08/23.
//

import UIKit

protocol modalViewPresentation: AnyObject{
  func didUpdateData()
}

class AddReviewViewController: UIViewController {
  
  @IBOutlet weak var sliderValue: UISlider!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var reviewField: UITextView!
  
  var delegate: modalViewPresentation?
  
  let viewModel = AddReviewViewModel()
  let refreshModel = RefreshTokenViewModel()
  var product: Int?
  
  func sendProductId(productId: Int){
    product = productId
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ratingLabel.text = "0.0"
    refreshModel.refreshToken()
  }
  
  @IBAction func sliderSliding(_ sender: UISlider) {
    ratingLabel.text = String(format: "%.0f",sliderValue.value)
  }
  
  @IBAction func backClicked(_ sender: UIButton) {
    refreshModel.refreshToken()
    self.dismiss(animated: true)
  }
  
  
  @IBAction func submitReviewClicked(_ sender: UIButton) {
    guard let product = product else {
      return }
    guard let token = UserDefaults.standard.string(forKey: "access_token") else { return }
    let rating = String(format: "%.0f", sliderValue.value)
    viewModel.addReview(productId: product, comment: reviewField.text!, rating: Double(rating)!, token: token) { response in
      DispatchQueue.main.async { [unowned self] in
        self.showAlert(title: "Success", message: response!.status){
          self.goToReview()
        }
      }
    } onError: { error in
      DispatchQueue.main.async { [unowned self] in
        self.showAlert(title: "Error", message: error.capitalized)
      }
    }
  }
  
  func goToReview() {
    let storyboard = UIStoryboard(name: "Review", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController
    vc!.getProductId(product: product!)
    delegate?.didUpdateData()
    self.dismiss(animated: true)
  }
  
  func logout(){
    if UserModel.deleteAll() {
      UserModel.stateLogin = false
      let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
      self.navigationController?.pushViewController(storyboard, animated: true)
    }
  }
}
