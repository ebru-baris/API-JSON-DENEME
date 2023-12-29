//
//  ViewController.swift
//  NewProductProject
//
//  Created by Ebru Barış on 29.12.2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    //MARK: - IBOUTLET
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - VARIABLES
    
    var model : [Model] = []
    
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        getData(arananKelime: "")
    }
    
    
    
    // MARK: - GET DATA
    
    func getData(arananKelime: String){
        var url = "https://dummyjson.com/products"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ [self]data, response, error in
            
            if error != nil || data == nil {
                print(error?.localizedDescription)
                return
            } else {
                
                do {
                    if let json =  try! JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                        if let products = json["products"] as? [[String:Any]]{
                            
                            var imagesArray = [Images]()
                            
                            model.removeAll()
                            
                            for product in products {
                                
                                if !arananKelime.isEmpty {
                                    if (product["title"] as? String)?.lowercased().range(of: arananKelime.lowercased()) != nil {
                                        
                                        if let imagesData = product["images"] as? [String] {
                                            var imagesArray = [Images]()
                                            for imageData in imagesData {
                                                imagesArray.append(Images(images: imageData))
                                            }
                                            model.append(Model(title: "\(product["title"]!)", description: "\(product["description"]!)",price: product["price"]! as? Int,thumbnail: "\(product["thumbnail"]!)",images: imagesArray))
                                        } else {
                                            print("imagesData değeri boş görünüyor.")
                                        }
                                    }
                                }else {
                                    if let imagesData = product["images"] as? [String] {
                                        var imagesArray = [Images]()
                                        for imageData in imagesData {
                                            imagesArray.append(Images(images: imageData))
                                        }
                                        model.append(Model(title: "\(product["title"]!)", description: "\(product["description"]!)",price: product["price"]! as? Int,thumbnail: "\(product["thumbnail"]!)",images: imagesArray))
                                    } else {
                                        print("imagesData değeri boş görünüyor.")                                    }
                                }
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                }
                            }
                            }
                        }
                    }catch {
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
    }
 


}

//MARK: - EXTENSION+COLLECTIONV

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let  text = searchController.searchBar.text else {
            return
        }
        getData(arananKelime: text)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        
        let item = model[indexPath.row]
        
        if indexPath.row < model.count {
            
            cell.productImage.sd_setImage(with: URL(string: item.thumbnail!)!)
            cell.productTitle.text = item.title
            
        } else {
            
            cell.productImage.sd_setImage(with: URL(string: item.thumbnail!)!)
            cell.productTitle.text = item.title
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secilenItem = model[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: secilenItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail",
           let hedefVC = segue.destination as? DetailVC, let secilenCell = sender as? Model {
            if let images = secilenCell.images {
                hedefVC.model = secilenCell
                hedefVC.images = images
            } else {
                print("Resim dizi boş ya da seçilen model boş")
            }
        }
    }
    
}
