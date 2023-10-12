//
//  HapticService.swift
//  GuessTheFlag
//
//  Created by Yasser Bal on 13/10/2023.
//

import Foundation
import SwiftUI
class HapticService{
    
    static let instance = HapticService()
    
    private init(){
        //
    }
    
    func notify(type:UINotificationFeedbackGenerator.FeedbackType){
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
        
    }
    
    func impact(style:UIImpactFeedbackGenerator.FeedbackStyle,intensity:CGFloat = CGFloat(1)){

        let generator = UIImpactFeedbackGenerator(style:style)
        generator.impactOccurred(intensity: intensity)

    }
}
