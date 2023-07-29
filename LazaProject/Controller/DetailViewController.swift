//
//  DetailViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
  
  // MARK: Get Welcome Element Data
  var viewModel: WelcomeElement!
  
  @IBOutlet weak var imageDetail: UIImageView!
  @IBOutlet weak var textCategory: UILabel!
  @IBOutlet weak var titleDetail: UILabel!
  @IBOutlet weak var priceTxtDetail: UILabel!
  @IBOutlet weak var descriptionTxtDetail: UILabel!
  @IBOutlet weak var textRatingDetail: UILabel!
  
  @IBOutlet weak var Star1: UIImageView!
  @IBOutlet weak var star2: UIImageView!
  @IBOutlet weak var star3: UIImageView!
  @IBOutlet weak var star4: UIImageView!
  @IBOutlet weak var star5: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let image = URL(string: viewModel.image) // Convert ImageString into URL
    imageDetail.sd_setImage(with: image) // Download image with SDWebImage Package
    // Set data For View
    textCategory.text = viewModel.category.rawValue.capitalized
    titleDetail.text = viewModel.title
    priceTxtDetail.text = "$"+String(viewModel.price)
    descriptionTxtDetail.text = viewModel.description
    textRatingDetail.text = " "+String(viewModel.rating.rate)
    setRatingImage(viewModel.rating.rate)
  }
  
  // MARK: Function that Configure Data from Collection into DetailView
  func configure(data: WelcomeElement) {
    viewModel = data
  }
  
  // MARK: Back button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: Function that Set Star Image Style from RatingValue in API
  func setRatingImage(_ value: Double){
    if value == 5 {
      Star1.image = UIImage(systemName: "star.fill")
      star2.image = UIImage(systemName: "star.fill")
      star3.image = UIImage(systemName: "star.fill")
      star4.image = UIImage(systemName: "star.fill")
      star5.image = UIImage(systemName: "star.fill")
      
      Star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemYellow
      star5.tintColor = .systemYellow
    } else if value >= 4 && value < 5 {
      Star1.image = UIImage(systemName: "star.fill")
      star2.image = UIImage(systemName: "star.fill")
      star3.image = UIImage(systemName: "star.fill")
      star4.image = UIImage(systemName: "star.fill")
      star5.image = UIImage(systemName: "star")
      
      Star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemYellow
      star5.tintColor = .systemGray
    } else if value >= 3 && value < 4 {
      Star1.image = UIImage(systemName: "star.fill")
      star2.image = UIImage(systemName: "star.fill")
      star3.image = UIImage(systemName: "star.fill")
      star4.image = UIImage(systemName: "star")
      star5.image = UIImage(systemName: "star")
      
      Star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value >= 2 && value < 3 {
      Star1.image = UIImage(systemName: "star.fill")
      star2.image = UIImage(systemName: "star.fill")
      star3.image = UIImage(systemName: "star")
      star4.image = UIImage(systemName: "star")
      star5.image = UIImage(systemName: "star")
      
      Star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value >= 1 && value < 2 {
      Star1.image = UIImage(systemName: "star.fill")
      star2.image = UIImage(systemName: "star")
      star3.image = UIImage(systemName: "star")
      star4.image = UIImage(systemName: "star")
      star5.image = UIImage(systemName: "star")
      
      Star1.tintColor = .systemYellow
      star2.tintColor = .systemGray
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    }
  }
}
