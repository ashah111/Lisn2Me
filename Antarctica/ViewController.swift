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
    
    let playService = PlayService()
    
    @IBAction func playTapped(_ sender: UIButton) {
        print("Play tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

