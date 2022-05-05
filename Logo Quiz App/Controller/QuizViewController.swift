//
//  QuizViewController.swift
//  Logo Quiz App
//
//  Created by Renzo Alvaroshan on 05/05/22.
//

import UIKit

// TODO: kalo soalnya udah ke jawab, update UI nya (cek dari CoreData)
// - Textfield udah keisi jawabannya, gabisa diubah
// - Button hint dihapus
// - Munculin logo aslinya
// Cek dari store.fetchUser()?.answeredQuestions?.contains("nama logonya")
class QuizViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!

    var answerOne = "Telkom"
    
    var characterNumber = 0
    
    var store: UserCoreDataStore {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return UserCoreDataStore(context: context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateScoreLabel()
        
        textField.addTarget(self, action: #selector(checkAnswer), for: .editingChanged)
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(store.fetchUser()?.score ?? 0)"
    }
    
    func reset() {
        textField.text = ""
        characterNumber = 0
        imageView.image = UIImage(named: "TELKOM")
    }

    @objc func checkAnswer() {
        let isCorrectAnswer = textField.text == answerOne
        
        if isCorrectAnswer {
            imageView.image = UIImage(systemName: "checkmark")
            
            // Add to user score
            store.addUserScore(amount: 10)
            
            // Update score in label
            updateScoreLabel()
            
            // Add answered question
            store.addAnsweredQuestion(answerOne)
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
