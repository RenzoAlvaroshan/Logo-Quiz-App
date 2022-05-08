//
//  LevelModel.swift
//  Logo Quiz App
//
//  Created by Hansel Matthew on 04/05/22.
//

import Foundation
import UIKit

struct Level
{
    var title: Int
    var progress: Int
    var maxProgress: Int
    var backgroundColor: UIColor
    
    
    func getLevelTitle() -> String {
        return "Level \(self.title)"
    }
    
    func getProgressString() -> String {
        return "\(self.progress)/\(self.maxProgress)"
    }
    
    func getPercentageString() -> String {
        let PercentComplete = Int(Double(self.progress)/Double(self.maxProgress)*100)
       return "\(PercentComplete)%"
    }
}
