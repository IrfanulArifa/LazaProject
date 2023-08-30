//
//  AllAddressTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 09/08/23.
//

import UIKit

class AllAddressTableViewCell: UITableViewCell {

  
  @IBOutlet weak var nameAddress: UILabel!
  @IBOutlet weak var cityAddress: UILabel!
  @IBOutlet weak var streetAddress: UILabel!
  @IBOutlet weak var numberAddress: UILabel!
  @IBOutlet weak var isPrimary: UIImageView!{
    didSet { isPrimary.isHidden = true }
  }
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
