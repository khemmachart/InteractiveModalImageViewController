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
        imageView.frame = self.senderFrame
        return imageView
    }()
    
    private lazy var actualFrame: CGRect = {
        return CGRect(x: 0,
                      y: 0,
                      width: self.view.frame.width,
                      height: self.view.frame.height)
    }()
    
    private lazy var senderFrame: CGRect = {
        if let sender = self.sender {
            let actualSenderPosition = sender.screenOrigin
            return CGRect(x: actualSenderPosition.x,
                          y: actualSenderPosition.y,
                          width: sender.frame.width,
                          height: sender.frame.height)
        }
        return CGRect.zero
    }()
    
    private let duration: TimeInterval = 0.25
    
    var sender: UIView?
    var image: UIImage?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentAnimation()
    }
    
    // MARK: - Action
    
    @IBAction private func dismissButtonDisPress(_ sender: UIView) {
        dismiss(animated: true)
    }
    
    // MARK: - Interface
    
    private func setupInterface() {
        setupInterfaceForPresentAnimation()
        view.addSubview(displayImageView)
    }
    
    private func setupInterfaceForPresentAnimation() {
        overlayView.alpha = OverlayViewAlpha.begin.rawValue
        displayImageView.frame = senderFrame
    }
    
    private func setupInterfaceForDismissAnimation() {
        overlayView.alpha = OverlayViewAlpha.done.rawValue
        displayImageView.frame = actualFrame
    }
    
    // MARK: - Animation
    
    private func animatePresentAnimation() {
        setupInterfaceForPresentAnimation()
        presentAnimation()
    }
    
    private func presentAnimation() {
        UIView.animate(withDuration: duration, animations: {
            self.setupInterfaceForDismissAnimation()
        })
    }
    
    // MARK: - Utils
    
    private enum OverlayViewAlpha: CGFloat {
        case begin = 0
        case prepare = 0.75
        case done = 1
    }
}

