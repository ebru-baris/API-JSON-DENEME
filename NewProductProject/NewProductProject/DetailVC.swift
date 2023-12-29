//
//  DetailVC.swift
//  NewProductProject
//
//  Created by Ebru Barış on 29.12.2023.
//

import UIKit

class DetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var model: Model?
    var images : [Images]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.title = model?.title
        descriptionTV.text = model?.description
        if let price = model?.price {
            priceLabel.text = String(price) + " TL"
        } else {
            priceLabel.text = "0 TL"
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! DetailCell
        if let imageURLString = images?[indexPath.row].images,
           let imageURL = URL(string: imageURLString){
            cell.detailImage.sd_setImage(with: imageURL)
        }
        
        return cell
    }

 

}
