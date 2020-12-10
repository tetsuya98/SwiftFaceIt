//
//  FaceView.swift
//  FaceIt
//
//  Created by Josselin on 26/11/2020.
//  Copyright © 2020 Josselin. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {

    @IBInspectable var scale: CGFloat = 0.9 {didSet {setNeedsDisplay()}}
    private var faceRadius: CGFloat {return min(bounds.size.width, bounds.size.height) / 2 * scale}
    private var faceCenter: CGPoint {return CGPoint(x: bounds.midX, y: bounds.midY)}
    @IBInspectable var lineWidth: CGFloat = 5.0
    @IBInspectable var lineColor: UIColor = UIColor.blue {didSet {setNeedsDisplay()}}
    @IBInspectable var eyesOpen: Bool = true {didSet {setNeedsDisplay()}}
    @IBInspectable var eyesHappy: Bool = false 
    @IBInspectable var mouthCurv: CGFloat = 1.2 {didSet {setNeedsDisplay()}}
    
    private func pathForFace() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = lineWidth
        return path
    }
    
    private enum Eye {
        case left
        case right
    }
    
    private struct Ratios {
        static let faceRadiusToEyeOffset: CGFloat = 2.5
        static let faceRadiusToEyeRadius: CGFloat = 5
        static let faceRadiusToMouthOffset: CGFloat = 3
        static let faceRadiusToMouthWidth: CGFloat = 0.8
        static let faceRadiusToMouthHeight: CGFloat = 4
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = faceRadius / Ratios.faceRadiusToEyeOffset
            var eyeCenter = faceCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = faceRadius / Ratios.faceRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        let path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        } else{
            if eyesHappy {
                path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
            } else {
                path = UIBezierPath()
                path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
                path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            }
        }
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthOffset = faceRadius / Ratios.faceRadiusToMouthOffset
        let mouthWidth = faceRadius / Ratios.faceRadiusToMouthWidth
        let mouthHeight = faceRadius / Ratios.faceRadiusToMouthHeight
        let mouthRect = CGRect(
            x: faceCenter.x - mouthWidth / 2,
            y: faceCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight
        )
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        let cp = CGPoint(x: mouthRect.midX, y: mouthRect.midY * mouthCurv) //?? mouthRect.minY
        let path = UIBezierPath()
        path.move(to: start)
        path.addQuadCurve(to: end, controlPoint: cp)
        path.lineWidth = lineWidth
        return path
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        lineColor.set()
        pathForFace().stroke()
        pathForEye(Eye.left).stroke()
        pathForEye(Eye.right).stroke()
        pathForMouth().stroke()
    }
    
    @objc func changeScale(pinchRecognizer: UIPinchGestureRecognizer) {
        if pinchRecognizer.state == .changed {
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        }
    }
    
}
