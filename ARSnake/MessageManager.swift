////
////  MessageManager.swift
////  ARSnake
////
////  Created by Jessie on 2017/8/5.
////  Copyright © 2017年 略懂工作室. All rights reserved.
////
//
//import UIKit
//
//class MessageManager {
//    private var viewController: ViewController!
//    private var messageHideTimer: Timer?
//
//    init(viewController: ViewController) {
//        self.viewController = viewController
//    }
//
//    func showMessage(_ text: String) {
//        // cancel any previous hide timer
//        messageHideTimer?.invalidate()
//
//        // set text
//        viewController.messageLabel.text = text
//
//        // Compute an appropriate amount of time to display the on screen message.
//        // According to https://en.wikipedia.org/wiki/Words_per_minute, adults read
//        // about 200 words per minute and the average English word is 5 characters
//        // long. So 1000 characters per minute / 60 = 15 characters per second.
//        // We limit the duration to a range of 1-10 seconds.
//        let charCount = text.characters.count
//        let displayDuration: TimeInterval = min(10, Double(charCount) / 15.0 + 1.0)
//        messageHideTimer = Timer.scheduledTimer(withTimeInterval: displayDuration,
//                                                repeats: false,
//                                                block: { [weak self] ( _ ) in
//                                                    self?.showHideMessage(hide: true, animated: true)
//        })
//    }
//
//    private func showHideMessage(hide: Bool, animated: Bool) {
//        if !animated {
//            viewController.messageLabel.isHidden = hide
//            return
//        }
//
//        UIView.animate(withDuration: 0.2,
//                       delay: 0,
//                       options: [.allowUserInteraction, .beginFromCurrentState],
//                       animations: {
//                        self.viewController.messageLabel.isHidden = hide
//                        self.updateMessagePanelVisibility()
//        }, completion: nil)
//    }
//
//    private func updateMessagePanelVisibility() {
//        // Show and hide the panel depending whether there is something to show.
//        viewController.messagePanel.isHidden = viewController.messageLabel.isHidden &&
//            viewController.debugMessageLabel.isHidden &&
//            viewController.featurePointCountLabel.isHidden
//    }
//}

