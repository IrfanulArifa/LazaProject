//
//  CategoryTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 31/07/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
  @IBOutlet weak var categoryCollectionCell: UICollectionView!
  var data: [String] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    categoryCollectionCell.dataSource = self
    categoryCollectionCell.delegate = self
    categoryCollectionCell.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure(_ arrayData: [String]){
    data = arrayData
    categoryCollectionCell.reloadData()
  }
  
}

extension CategoryTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let dataCell = data[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell()}
    cell.categoryTxt.text = dataCell.capitalized
    return cell
  }
}

extension CategoryTableViewCell: UICollectionViewDelegate {
  
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 150, height: 50)
  }
}
