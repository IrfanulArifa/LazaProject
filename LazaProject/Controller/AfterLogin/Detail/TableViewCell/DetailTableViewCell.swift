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
  
  let dummy = ["S", "M", "L", "XL", "XXL", "XXXL", "XXXXL"]
  
  @IBOutlet weak var sizeCollection: UICollectionView!
  override func awakeFromNib() {
    super.awakeFromNib()
    
    sizeCollection.dataSource = self
    sizeCollection.delegate = self
    sizeCollection.register(UINib(nibName: "SizeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SizeCollectionViewCell")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

extension DetailTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dummy.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = dummy[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeCollectionViewCell", for: indexPath) as? SizeCollectionViewCell else { return UICollectionViewCell() }
    cell.sizeLabel.text = data
    return cell
  }
  
  
}

extension DetailTableViewCell: UICollectionViewDelegate {
  
}

extension DetailTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 60, height: 60)
  }
}
