//============================================================
//  ViewController.swift                                     =
//  NASA_APP                                                 =
//  Created by Mushabab Alasmari on 06/06/1439 AH.           =
//  Copyright © 1439 Mushabab Alasmari. All rights reserved. =
//============================================================

// TODO:  2) Adding loading element for the API
// FIXME: 3) Catch Exceptions
// FIXME: 4) Auto-Layout for variant screens.
// FIXME: 5) Clean the code.

import UIKit
import youtube_ios_player_helper

struct NASA : Decodable {
    
    var date : String
    var explanation : String
    var hdurl : String
    var media_type : String
    var service_version : String
    var title : String
    var url : String
    
    init(nasa : NASA) {
        
        date = nasa.date
        explanation = nasa.explanation
        hdurl = nasa.hdurl
        media_type = nasa.media_type
        service_version = nasa.service_version
        title = nasa.title
        url = nasa.url
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var credit: UILabel!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var nasaText: UITextView!
    @IBOutlet weak var videoView: YTPlayerView!
    @IBOutlet weak var imgView: UIImageView!
    
    var nasa : NASA?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getNASA_Data()
    }
    
    func setup() {
        
        imgView.isHidden = true
        videoView.isHidden = true
        nasaText.isHidden = true
        
        videoView.backgroundColor = UIColor.clear
        nasaText.backgroundColor = UIColor.clear
        nasaText.textAlignment = .justified
        nasaText.isEditable = false
    }
    
    func getNASA_Data() {
        
        let API_key = "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(API_key)"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let nasa = try
                    JSONDecoder().decode(NASA.self, from: data)
                
                DispatchQueue.main.async(execute: {
                    self.populate(nasa: nasa)
                })
                
            } catch let jsonErr {
                print("Error serializing json: ", jsonErr)
            }
            
            }.resume()
        
    }
    
    func populate(nasa : NASA) {
        
        nasa.media_type == "image" ? setImageView(url: nasa.url)
            : setVideoView(url: nasa.url)
        
        credit.text = nasa.date
        textTitle.text = nasa.title
        nasaText.text = nasa.explanation
        nasaText.isHidden = false
    }
    
    func setImageView(url : String) {
        
        let imageData = try? Data(contentsOf: URL(string: url)!)
        imgView.image = UIImage(data: imageData!)
        imgView.isHidden = false
        videoView.isHidden = true
    }
    
    func setVideoView(url : String) {
        
        let videoId = url.split(separator: "/").last?
            .split(separator: "?").first
        videoView.load(withVideoId: String(videoId!))
        imgView.isHidden = true
        videoView.isHidden = false
    }
    
    
    //  STILL NOT WORKING...
    
//    func startActivityIndicator(indicator : UIActivityIndicatorView) {
//
//        indicator.center = self.view.center
//        indicator.hidesWhenStopped = true
//        view.addSubview(indicator)
//        indicator.startAnimating()
//    }
//
//    func stopActivityIndicator(indicator : UIActivityIndicatorView) {
//
//        indicator.stopAnimating()
//    }
    
}

