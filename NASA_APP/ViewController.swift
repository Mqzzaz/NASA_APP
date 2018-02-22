//
//  ViewController.swift
//  NASA_APP
//
//  Created by Mushabab Alasmari on 06/06/1439 AH.
//  Copyright © 1439 Mushabab Alasmari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var nasaImage: UIImageView!
    @IBOutlet weak var credit: UILabel!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var text: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNASA_Data()
    }

    //TODO: didnt work....why????
    func getNASA_Data()
    {
        let API_key = "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
        let url = "https://api.nasa.gov/planetary/apod?api_key=\(API_key)"
        Alamofire.request(url).response { response in
            
            let json = JSON(response.data!)
            
            let url = URL(string : json["url"].stringValue)
            let imageData = try? Data(contentsOf: url!)
            self.nasaImage.image = UIImage(data: imageData!)
            self.credit.text = json["copyright"].stringValue
            self.textTitle.text = json["title"].stringValue
            self.text.text = json["explanation"].stringValue
            
        }
    }
}

