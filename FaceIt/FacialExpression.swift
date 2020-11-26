//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Josselin on 26/11/2020.
//  Copyright © 2020 Josselin. All rights reserved.
//

import Foundation

struct FacialExpression {
    enum Eyes: Int {
        case open
        case closed
        //case happy
        //case sleep
    }
    
    enum Mouth: Int {
        case smile
        case frown
        case neutral
        
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    
    let eyes: Eyes
    let mouth: Mouth
    
    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }
    
}
