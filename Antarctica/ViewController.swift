//
//  ViewController.swift
//  Antarctica
//
//  Created by Ayushi shah on 2019-04-18.
//  Copyright © 2019 Ayushi Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var DeviceName: UILabel!
    @IBOutlet weak var nowPlaying: UILabel!
    
    let playService = PlayService()
    
    @IBAction func playTapped(_ sender: UIButton) {
        print("Play tapped")
        let songName = UIDevice.current.name
        self.nowPlaying.text = songName
        playService.send(songUri: songName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playService.delegate = self
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

