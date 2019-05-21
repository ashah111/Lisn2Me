//
//  ViewController.swift
//  Antarctica
//
//  Created by Ayushi shah on 2019-04-18.
//  Copyright © 2019 Ayushi Shah. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    
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
        
        //get access token
        let userDefaults = UserDefaults.standard
        if let access_token = userDefaults.string(forKey: "access-token-key"){
            let headers: HTTPHeaders = [
                "Authorization": "Bearer " + access_token,
                "Accept": "application/json",
                "Content-Type": "application/json"
            ];
            Alamofire.request("https://api.spotify.com/v1/me/player/currently-playing?market=ES",method: .get, headers: headers).responseJSON { (response) in
                debugPrint(response)
            }
            
        }
        
        let songName = "asdasda"
        self.nowPlaying.text = songName
        playService.send(songUri: songName)
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

