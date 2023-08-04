//
//  AddReviewViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 03/08/23.
//

import UIKit

class AddReviewViewController: UIViewController {
  
  @IBOutlet weak var sliderValue: UISlider!
  @IBOutlet weak var ratingLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ratingLabel.text = "0.0"
  }
  
  @IBAction func sliderSliding(_ sender: UISlider) {
    ratingLabel.text = String(format: "%.1f",sliderValue.value)
  }
  
  @IBAction func backClicked(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  
  @IBAction func submitReviewClicked(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
}
