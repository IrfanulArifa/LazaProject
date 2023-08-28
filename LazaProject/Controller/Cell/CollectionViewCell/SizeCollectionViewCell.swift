//
//  SizeCollectionViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 03/08/23.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var sizeLabel: UILabel!
  
  private(set) var sizeId: Int?
  private(set) var sizeText: String?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configure(sizeId: Int, sizeText: String) {
    self.sizeId = sizeId
    self.sizeText = sizeText
    sizeLabel.text = sizeText
  }
}
