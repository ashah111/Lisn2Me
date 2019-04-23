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
    @IBOutlet weak var connectionsLabel: UILabel!
    @IBOutlet weak var goLiveLabel: UILabel!
    @IBOutlet weak var goLiveSwitch: UISwitch!
    
    let playService = PlayService()
    
    
    @IBAction func goLiveSwitchToggled(_ sender: UISwitch) {
        
        let isOn = sender.isOn == true
        goLiveLabel.textColor = isOn ? UIColor.green : UIColor.red
        
        if (isOn) {
            playService.goLive()
        } else {
            playService.goOffline()
        }
        
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        print("Play tapped")
<<<<<<< HEAD
        self.nowPlaying.text = "Reminder - The Weeknd"
        playService.send(songUri: "Reminder - The Weeknd")
        let player = SpotifyPlayerViewController()
        player.getMusic()
=======
        let songName = UIDevice.current.name
        self.nowPlaying.text = songName
        playService.send(songUri: songName)
>>>>>>> d2309aeee7c25f24138d53301a87a80e43ec7279
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playService.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
  
    }
    
    func refreshData(_ connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.DeviceName.text = "\(connectedDevices)"
            self.connectionsLabel.text = "Connections: \(self.playService.session.connectedPeers.count) Device(s) Connected!"
        }
    }
}

extension ViewController : PlayServiceDelegate {
    
    func connectedDevicesChanged(manager: PlayService, connectedDevices: [String]) {
        refreshData(connectedDevices)
    }
    
    func playTapReceived(manager: PlayService, songUri: String) {
        OperationQueue.main.addOperation {
            self.nowPlaying.text = songUri
            print("Received song name = \(songUri)")
            
        }
    }
    
}

