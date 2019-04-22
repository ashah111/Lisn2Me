//
//  SpotifyPlayer.swift
//  Antarctica
//
//  Created by Ayushi shah on 2019-04-22.
//  Copyright © 2019 Ayushi Shah. All rights reserved.
//

import Foundation

class SpotifyPlayerViewController: UITableViewController {
    override func viewDidLoad() {
        
    }
    
    
    func getMusic(){
        let api = "https://api.spotify.com/v1/me/player"
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: api) as! URL
        
    }
   
}
