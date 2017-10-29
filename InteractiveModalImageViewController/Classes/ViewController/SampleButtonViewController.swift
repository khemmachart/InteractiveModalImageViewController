//
//  SampleButtonViewController.swift
//  InteractiveModalImageViewController
//
//  Created by KHUN NINE on 7/5/17.
//  Copyright © 2017 Santora Nakama. All rights reserved.
//

import UIKit

class SampleButtonViewController: UIViewController {

    @IBOutlet private weak var imageButton: UIButton!
    
    // MARK: - Action
    
    @IBAction func imageButtonDidPress(_ sender: UIButton) {
        presentImageViewController(sender.imageView)
    }
    
    // MARK: - Util
    
    private func presentImageViewController(_ sender: UIImageView?) {

        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let sID = "InteractiveModalImageViewController"
        if let viewController = stroyboard.instantiateViewController(withIdentifier: sID) as? InteractiveModalImageViewController {
            viewController.image = sender?.image
            present(viewController, animated: false, completion: nil)
        }
    }
}
