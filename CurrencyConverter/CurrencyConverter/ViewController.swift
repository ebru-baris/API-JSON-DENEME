//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ebru Barış on 3.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getRatesButton(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        
        // 1.
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=94eae2f88e5b3c422c0eb89db3d2ab36")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2.
                
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                              //  print(rates)
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = " CAD:  \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = " CHF:  \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = " GBP:  \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = " JPY:  \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = " USD:  \(usd)"
                                }
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = " TRY:  \(turkish)"
                                }
                            }
                            
                        }
                        
                    }catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
        
    }
    

}

