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
        
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ LevelModel: Level)
    {
        LevelLabel.text = LevelModel.getLevelTitle()
        ProgressLabel.text = LevelModel.getProgressString()
        PercentageCompletedLabel.text = LevelModel.getPercentageString()
    }
    
}
