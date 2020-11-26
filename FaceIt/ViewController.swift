//
//  ViewController.swift
//  FaceIt
//
//  Created by Josselin on 26/11/2020.
//  Copyright © 2020 Josselin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            let pinchHandler = #selector(faceView.changeScale(pinchRecognizer:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: pinchHandler)
            faceView.addGestureRecognizer(pinchRecognizer)
            updateUI()
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        func randomColor() -> UIColor {
            return UIColor(
              red: CGFloat.random(in: 0...1),
              green: CGFloat.random(in: 0...1),
              blue: CGFloat.random(in: 0...1),
              alpha: 1.0)
          }
        
        if motion == .motionShake {
            faceView.lineColor = randomColor() //UIColor.red
        }
    }
    
    private let mouthCurv = [
        FacialExpression.Mouth.frown: 0.8,
        .neutral: 1,
        .smile: 1.2
    ]
    
    var expression = FacialExpression(eyes: .open, mouth: .neutral) {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
            //faceView?.eyesHappy = false
        //case .happy:
            //faceView?.eyesOpen = false
            //faceView?.eyesHappy = true
        }
        faceView?.mouthCurv = CGFloat(mouthCurv[expression.mouth] ?? 1.0)
    }

}

