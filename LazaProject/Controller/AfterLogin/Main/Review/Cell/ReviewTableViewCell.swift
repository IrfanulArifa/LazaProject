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
    
}
