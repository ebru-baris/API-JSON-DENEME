//
//  ViewController.swift
//  NewsAppYeni
//
//  Created by Ebru Barış on 1.01.2024.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model : [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    func getData() {
        WebServices.shared.fetchNews { model in
            if let model = model {
                DispatchQueue.main.async {
                    self.model = model
                    self.tableView.reloadData()
                }
            }else{
                print("Veri Gelmedi")
            }
        }
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        let item = model[indexPath.row]
        cell.newsTitle.text = item.title
        cell.newsDescription.text = item.description
        cell.newsImage.sd_setImage(with: URL(string: item.urlToImage ?? "NIL"))
        return cell
    }
    
    
}
