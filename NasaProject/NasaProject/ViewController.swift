//
//  ViewController.swift
//  NasaProject
//
//  Created by Ebru Barış on 25.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nasaImage: UIImageView!
    @IBOutlet weak var nasaTitle: UILabel!
    @IBOutlet weak var nasaExplanation: UITextView!
    @IBOutlet weak var nasaDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData(){
        var request = URLRequest(url: URL(string: "https://api.nasa.gov/planetary/apod?api_key=8wdQkH90lxpUbDhEzrO1oS2bO95Ch49ZvuwK0SG7")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            if error != nil{
                return
            }else{
                if let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any] {
                    let title = json["title"] as? String ?? "BOŞ"
                    let date = json["date"] as? String ?? "BOŞ"
                    let explanation = json["explanation"] as? String ?? "BOŞ"
                    let hdurl = json["hdurl"] as? String ?? "BOŞ"
                    
                    //print(json)
                    
                    DispatchQueue.main.sync {
                        self.nasaTitle.text = title
                        self.nasaDate.text = date
                        self.nasaExplanation.text = explanation
                        do{
                            self.nasaImage.image = UIImage(data: try Data(contentsOf: URL(string: hdurl)!))
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }.resume()
    }

}

// Yasin Halit Karayağız Youtube anlatımı
