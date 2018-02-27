//
//  ViewController.swift
//  NASA_APP
//
//  Created by Mushabab Alasmari on 06/06/1439 AH.
//  Copyright © 1439 Mushabab Alasmari. All rights reserved.
//

// TODO:  2) Adding loading element for the API
// FIXME: 3) Catch Exceptions
// FIXME: 4) Auto-Layout for variant screens.
// FIXME: 5) Clean the code.

import UIKit
import Alamofire
import SwiftyJSON
import youtube_ios_player_helper

class ViewController: UIViewController {
    
    @IBOutlet weak var credit: UILabel!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var nasaText: UITextView!
    @IBOutlet weak var videoView: YTPlayerView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nasaText.backgroundColor = UIColor.clear
        videoView.backgroundColor = UIColor.clear
        nasaText.textAlignment = .justified
        getNASA_Data()
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    
    func getNASA_Data()
    {
        let API_key = "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
        let url = "https://api.nasa.gov/planetary/apod?api_key=\(API_key)"
        
        Alamofire.request(url).response
            { response in
            
            let json = JSON(response.data!)
            let url = json["url"].stringValue
            
            if (json["media_type"].stringValue == "image")
            {
                self.setImageView(url: url)
            }
            else
            {
                self.setVideoView(url: url)
            }
            
            self.credit.text = json["date"].stringValue
            self.textTitle.text = json["title"].stringValue
            self.nasaText.text = json["explanation"].stringValue
        }
    }
    
    func setImageView(url : String)
    {
        let imageData = try? Data(contentsOf: URL(string: url)!)
        self.imgView.image = UIImage(data: imageData!)
        self.imgView.isHidden = false
        self.videoView.isHidden = true
    }
    
    func setVideoView(url : String)
    {
        let videoId = url.split(separator: "/").last?
            .split(separator: "?").first
        self.videoView.load(withVideoId: String(videoId!))
        self.imgView.isHidden = true
        self.videoView.isHidden = false
    }
}

