//
//  SelectLevelTableViewCell.swift
//  Logo Quiz App
//
//  Created by Hansel Matthew on 04/05/22.
//

import UIKit

class SelectLevelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var ProgressLabel: UILabel!
    @IBOutlet weak var PercentageCompletedLabel: UILabel!
    @IBOutlet weak var LevelProgressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ LevelModel: level){
        LevelLabel.text = LevelModel.title
        let ProgressText = "\(LevelModel.progress)/\(LevelModel.maxProgress)"
        
        ProgressLabel.text = ProgressText
        let PercentComplete = Double(LevelModel.progress)/Double(LevelModel.maxProgress)*100
        let PercentText = "\(PercentComplete)%"
        print(PercentText)
        PercentageCompletedLabel.text = PercentText
        
        
    }
}
