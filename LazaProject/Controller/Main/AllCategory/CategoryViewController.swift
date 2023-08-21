//
//  CategoryViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 21/08/23.
//

import UIKit

class CategoryViewController: ViewController {
  
  var category: [Description]?
  
  @IBOutlet weak var allCategory: UICollectionView!{
    didSet {
      allCategory.dataSource = self
      allCategory.delegate = self
      allCategory.register(UINib(nibName: "AllCatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllCatCollectionViewCell")
    }
  }
  
  func AllCategoryConfigure(data: [Description]){
    category = data
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
  }
}

extension CategoryViewController: UICollectionViewDelegate{
  
}

extension CategoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return category!.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllCatCollectionViewCell", for: indexPath) as? AllCatCollectionViewCell else { return UICollectionViewCell() }
    return cell
  }
  
  
}
