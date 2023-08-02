//
//  DetailTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 02/08/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
  
  @IBOutlet weak var imageDetail: UIImageView!
  @IBOutlet weak var categoryDetailLabel: UILabel!
  @IBOutlet weak var productNameDetailLabel: UILabel!
  @IBOutlet weak var priceDetailLabel: UILabel!
  @IBOutlet weak var extraDetailCollection: UICollectionView!
  @IBOutlet weak var reviewValueDetail: UILabel!
  @IBOutlet weak var descriptionDetail: UILabel!
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
  }
}
