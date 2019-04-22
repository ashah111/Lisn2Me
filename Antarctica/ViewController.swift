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
    @IBOutlet weak var nowPlaying: UILabel!
    
    let playService = PlayService()
    
    @IBAction func playTapped(_ sender: UIButton) {
        print("Play tapped")
        self.nowPlaying.text = "Reminder - The Weeknd"
        playService.send(songUri: "Reminder - The Weeknd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
    }
}

extension ViewController : PlayServiceDelegate {
    
    func connectedDevicesChanged(manager: PlayService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.DeviceName.text = "\(connectedDevices)"
        }
    }
    
    func playTapReceived(manager: PlayService, songUri: String) {
        OperationQueue.main.addOperation {
            self.nowPlaying.text = songUri
            print("Received song name = \(songUri)")
        }
    }
    
}

