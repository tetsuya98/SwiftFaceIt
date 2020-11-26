//
//  FaceView.swift
//  FaceIt
//
//  Created by Josselin on 26/11/2020.
//  Copyright © 2020 Josselin. All rights reserved.
//

import UIKit

class FaceView: UIView {

    var scale: CGFloat = 0.9
    private var faceRadius: CGFloat {return min(bounds.size.width, bounds.size.height) / 2 * scale}
    private var faceCenter: CGPoint {return CGPoint(x: bounds.midX, y: bounds.midY)}
    private var lineWidth: CGFloat = 5.0
    private var lineColor = UIColor.blue
    private var eyesOpen: Bool = true
    private var eyesHappy: Bool = true
    
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
        static let faceRadiusToMouthWidth: CGFloat = 1
        static let faceRadiusToMouthHeight: CGFloat = 3
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

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        lineColor.set()
        pathForFace().stroke()
        pathForEye(Eye.left).stroke()
        pathForEye(Eye.right).stroke()
    }
    

}
