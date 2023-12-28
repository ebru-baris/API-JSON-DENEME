//
//  ViewController.swift
//  KanyeWestQuotesAPI
//
//  Created by Ebru Barış on 25.12.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func randomQuoteButton(_ sender: Any) {
        let url = URL(string: "https://api.kanye.rest")!
        let task = URLSession.shared.dataTask(with: url){ (data:Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                print(error)
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: String]
            DispatchQueue.main.async {
                self.quoteLabel.text = json["quote"]
            }
        }
        task.resume()
    }
    
}

// Ahmet Ali Çetin youtube anlatımı
