//
//  ViewController.swift
//  Weather Logger
//
//  Created by Syed Ubaid Khan on 3/15/20.
//  Copyright © 2020 Syed Ubaid Khan. All rights reserved.
//

import UIKit
import SwiftyGif

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let gif = try UIImage(gifName: "splash.gif")
            let imageview = UIImageView(gifImage: gif, loopCount: 3) // Use -1 for infinite loop
            imageview.contentMode = .scaleAspectFit
            imageview.frame = view.bounds
            view.addSubview(imageview)
        } catch {
            print(error)
        }
        let deadlineTime = DispatchTime.now() + .seconds(6)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            let vc : MainViewController = MainViewController(nibName: "MainViewController", bundle: nil);
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true) {
                
            }

        }
        // Do any additional setup after loading the view.
    }

    
}

