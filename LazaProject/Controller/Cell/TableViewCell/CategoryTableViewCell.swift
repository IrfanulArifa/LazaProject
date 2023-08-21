//
//  CategoryTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 31/07/23.
//

import UIKit
import SDWebImage

class CategoryTableViewCell: UITableViewCell {
  @IBOutlet weak var categoryCollectionCell: UICollectionView!
  
  var data = [Description]()
  
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
  
  @IBAction func viewAllClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
    vc.AllCategoryConfigure(data: data)
//    self.navigationContro
  }
  
  func configure(_ arrayData: [Description]){
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
    cell.categoryTxt.text = dataCell.name.capitalized
    let imageData = dataCell.logoURL
    cell.imageBrand.sd_setImage(with: URL(string:imageData))
    return cell
  }
}

extension CategoryTableViewCell: UICollectionViewDelegate {
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    for _ in 0...indexPath.item {
//      let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
//      let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
//      let size:CGFloat = ((collectionView.frame.size.width - space) / 2.0) + 20
//
//    }
    return CGSize(width: 200, height: 50)
//    return CGSize(width: size, height: size)
    
    
  }
  
}
