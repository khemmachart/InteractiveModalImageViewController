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
    
    private var initialTouchPoint = CGPoint(x: 0,y: 0)
    private let dragingDismissDistance: CGFloat = 80
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
    
    @IBAction private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        switch sender.state {
            
        case .began:
            initialTouchPoint = touchPoint
            
        case .changed:
            if overlayView.alpha > OverlayViewAlpha.prepare.rawValue {
                setupInterfaceForDismissAnimationPreparation()
            }
            let yPosition = touchPoint.y - initialTouchPoint.y
            let xPosition = touchPoint.x - initialTouchPoint.x
            displayImageView.frame = CGRect(x: xPosition,
                                            y: yPosition,
                                            width: view.bounds.width,
                                            height: view.bounds.height)
            
        case .ended, .cancelled:
            if isReachedDismissPosition(curPosition: touchPoint) {
                dismiss(animated: true)
            } else {
                presentAnimation()
            }
            
        default:
            break
        }
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
    
    private func setupInterfaceForDismissAnimationPreparation() {
        UIView.animate(withDuration: duration, animations: {
            self.dismissButton.isHidden = true
            self.overlayView.alpha = OverlayViewAlpha.prepare.rawValue
        })
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
    
    private func dismissAnimation(completionHandler handler: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration * 2,
                       delay: 0.0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 1,
                       options: [.curveEaseInOut],
                       animations: {
                        self.setupInterfaceForPresentAnimation()
        }, completion: { complete in
            handler?()
        })
    }
    
    // MARK: - Utils
    
    private func isReachedDismissPosition(curPosition: CGPoint) -> Bool {
        let isOverYPosition = abs(curPosition.y - initialTouchPoint.y) > dragingDismissDistance
        let isOverXPosition = abs(curPosition.x - initialTouchPoint.x) > dragingDismissDistance
        return isOverYPosition || isOverXPosition
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if flag {
            dismissAnimation(completionHandler: {
                super.dismiss(animated: false, completion: completion)
            })
        } else {
            super.dismiss(animated: false, completion: completion)
        }
        
    }
    
    private enum OverlayViewAlpha: CGFloat {
        case begin = 0
        case prepare = 0.75
        case done = 1
    }
}

