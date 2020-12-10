//
//  EmotionViewController.swift
//  FaceIt
//
//  Created by Josselin Abel on 10/12/2020.
//  Copyright © 2020 Josselin. All rights reserved.
//

import UIKit

class EmotionViewController: UIViewController {

    // MARK: - Navigation
    
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "sleeping": FacialExpression(eyes: .closed, mouth: .neutral),
        "sad": FacialExpression(eyes: .open, mouth: .frown),
        "happy": FacialExpression(eyes: .open, mouth: .smile)
    ]
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationController = segue.destination
        if let navigationController = destinationController as? UINavigationController {
            destinationController = navigationController.visibleViewController ?? destinationController
            if let faceViewController = destinationController as? FaceViewController {
                if let newExpression = emotionalFaces[segue.identifier!] {
                    faceViewController.expression = newExpression
                    faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
}
