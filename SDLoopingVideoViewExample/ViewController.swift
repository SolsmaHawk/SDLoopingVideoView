//
//  ViewController.swift
//  SDLoopingVideoViewExample
//
//  Created by ZuluAlpha on 2/22/19.
//  Copyright © 2019 Solsma Dev Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment out the bottom two lines to see how to programtically add an SDLoopingVideoView
        // let loopingVideoView = SDLoopingVideoView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200), video: .video(fileName: "solsmaDev_logo", fileExtension: .mov), darkModeVideo: .video(fileName: "velocityBreaker_video", fileExtension: .mov))
        // view.addSubview(loopingVideoView)
    }

    @IBAction func viewDarkModeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showDarkModeDemo", sender: nil)
    }
    
}

