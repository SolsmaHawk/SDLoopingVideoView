//
//  DarkModeDemoViewController.swift
//  SDLoopingVideoViewExample
//
//  Created by John Solsma on 3/21/20.
//  Copyright © 2020 Solsma Dev Inc. All rights reserved.
//

import UIKit

class DarkModeDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
