//
//  QuizViewController.swift
//  Logo Quiz App
//
//  Created by Renzo Alvaroshan on 05/05/22.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!

    var answerOne = "Telkom"
    
    var characterNumber = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.addTarget(self, action: #selector(checkAnswer), for: .editingChanged)
    }
    
    func reset() {
        textField.text = ""
        characterNumber = 0
        imageView.image = UIImage(named: "TELKOM")
    }

    @objc func checkAnswer() {
        if textField.text == answerOne {
            imageView.image = UIImage(systemName: "checkmark")
            score += 10
            scoreLabel.text = String(score)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if characterNumber == 0 {
            textField.text = answerOne[characterNumber]
        } else {
            textField.text! += answerOne[characterNumber]
        }
        
        characterNumber += 1
        
        checkAnswer()
    }

    @IBAction func resetTapped(_ sender: UIButton) {
        reset()
    }
}
