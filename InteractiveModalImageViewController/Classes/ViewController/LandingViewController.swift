//
//  LandingViewController.swift
//  InteractiveModalImageViewController
//
//  Created by Khemmachart Chutapetch on 10/29/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBAction private func viewControllerButtonDidPress(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SampleButtonViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction private func tableViewControllerButtonDidPress(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SampleTableViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
}
