//
//  ViewController.swift
//  Antarctica
//
//  Created by Ayushi shah on 2019-04-18.
//  Copyright © 2019 Ayushi Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let kCLientID = "01f5dc56a7e4490f882e0ac1dcf8d72d"
    let kCallbackURL = "spotify-ios-quick-start://spotify-login-callback"
    let kTokenSwapURL = "http://localhost:1234/swap"
    let kTokenRefreshServiceURL = "http://localhost:1234/refresh"
    
    var session: SPTSession!
    var player: SPTAppRemotePlayerAPI?
    @IBOutlet weak var DeviceName: UILabel!
    
    let playService = PlayService()
    
    @IBAction func playTapped(_ sender: UIButton) {
        print("Play tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
    }


}

