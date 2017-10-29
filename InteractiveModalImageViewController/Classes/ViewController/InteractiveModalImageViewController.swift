//
//  InteractiveModalImageViewController.swift
//  InteractiveModalImageViewController
//
//  Created by KHUN NINE on 3/23/17.
//  Copyright © 2017 KHUN NINE. All rights reserved.
//

import UIKit

class InteractiveModalImageViewController: UIViewController {
    
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!

    private lazy var displayImageView: UIImageView = {
        let imageView = UIImageView(frame: self.containerView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.image
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: self.view.frame.width,
                                 height: self.view.frame.height)
        return imageView
    }()
    
    var image: UIImage?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    // MARK: - Action
    
    @IBAction private func dismissButtonDisPress(_ sender: UIView) {
        dismiss(animated: true)
    }

    // MARK: - Interface

    private func setupInterface() {
        view.addSubview(displayImageView)
    }
}
