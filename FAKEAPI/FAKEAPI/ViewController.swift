//
//  ViewController.swift
//  FAKEAPI
//
//  Created by Ebru Barış on 27.12.2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        verileriGetir()
    }
    
    //MARK: - VERİLERİ GETİR
    
    func verileriGetir(){
        
        var url = "https://fakestoreapi.com/products"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil || data == nil {
                print(error?.localizedDescription)
                return
            }else{
                do{
                    if let json = try! JSONSerialization.jsonObject(with: data!,options: []) as? [[String:Any]]{
                        
                        //print(json)
                        
                        for eleman in json{
                            self.model.append(Model(title: "\(eleman["title"]!)", image: "\(eleman["image"]!)"))
                        }
                        DispatchQueue.main.sync {
                            self.collectionView.reloadData()
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    //MARK: - COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        let item = model[indexPath.row]
        cell.productImage.sd_setImage(with: URL(string: item.image!))
        cell.productTitle.text = item.title
        return cell
    }
}

