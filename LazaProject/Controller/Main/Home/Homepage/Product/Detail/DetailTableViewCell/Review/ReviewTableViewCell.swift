//
//  ReviewTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 03/08/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
  
  @IBOutlet weak var reviewerName: UILabel!
  @IBOutlet weak var reviewDate: UILabel!
  @IBOutlet weak var reviewerImage: UIImageView!
  @IBOutlet weak var reviewerValue: UILabel!
  @IBOutlet weak var reviewDescription: UILabel!
  
  @IBOutlet weak var star1: UIImageView!
  @IBOutlet weak var star2: UIImageView!
  @IBOutlet weak var star3: UIImageView!
  @IBOutlet weak var star4: UIImageView!
  @IBOutlet weak var star5: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setRatingImage(_ value: Double){
    let imageFull = UIImage(systemName: "star.fill")
    let imageHalf = UIImage(systemName: "star.leadinghalf.filled")
    let imageEmpty = UIImage(systemName: "star")
    let colorFill = UIColor(named: "starColor")
    
    if value == 5 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageFull
      star5.image = imageFull
      
      star1.tintColor = colorFill
      star2.tintColor = colorFill
      star3.tintColor = colorFill
      star4.tintColor = colorFill
      star5.tintColor = colorFill
    } else if value == 4 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageFull
      star5.image = imageEmpty
      
      star1.tintColor = colorFill
      star2.tintColor = colorFill
      star3.tintColor = colorFill
      star4.tintColor = colorFill
      star5.tintColor = colorFill
    } else if value == 3 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = colorFill
      star2.tintColor = colorFill
      star3.tintColor = colorFill
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value == 2 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = colorFill
      star2.tintColor = colorFill
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value == 1 {
      star1.image = imageFull
      star2.image = imageEmpty
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = colorFill
      star2.tintColor = .systemGray
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value == 0 {
      star1.image = imageEmpty
      star2.image = imageEmpty
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = .systemGray
      star2.tintColor = .systemGray
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value > 4 && value < 5 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageFull
      star5.image = imageHalf
      
      star1.tintColor = colorFill
      star2.tintColor = colorFill
      star3.tintColor = colorFill
      star4.tintColor = colorFill
      star5.tintColor = colorFill
    } else if value > 3 && value < 4 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageHalf
      star5.image = imageEmpty
      
      star1.tintColor = colorFill
      star2.tintColor = colorFill
      star3.tintColor = colorFill
      star4.tintColor = colorFill
      star5.tintColor = .systemGray
    } else if value > 2 && value < 3 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageHalf
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = colorFill
      star2.tintColor = colorFill
      star3.tintColor = colorFill
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value > 1 && value < 2 {
      star1.image = imageFull
      star2.image = imageHalf
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = colorFill
      star2.tintColor = colorFill
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value > 0 && value < 1 {
      star1.image = imageHalf
      star2.image = imageEmpty
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = colorFill
      star2.tintColor = .systemGray
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    }
  }
}
