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

@objc protocol QuizViewControllerDelegate
{
    @objc optional func onCorrectAnswer()
}

class QuizViewController: UIViewController
{
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var hintButton: UIButton!
    
    weak var delegate: QuizViewControllerDelegate?
    
    var logo: Logo?
    
    var characterNumber = 0
    
    var store: UserCoreDataStore {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return UserCoreDataStore(context: context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Guess The Logo"
        
        updateScoreLabel()
        
        textField.addTarget(self, action: #selector(checkAnswer), for: .editingChanged)
        
        reset()
        
        let isAnswered = store.fetchUser()?.answeredQuestions?.contains(logo!.name) ?? false
        if (isAnswered)
        {
            hintButton.isHidden = true
            textField.text = logo?.name
            textField.isUserInteractionEnabled = false
        }
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(store.fetchUser()?.score ?? 0)"
    }
    
    func reset() {
        textField.text = ""
        characterNumber = 0
        imageView.image = UIImage(named: logo!.imageUrl)
    }

    @objc func checkAnswer() {
        let isCorrectAnswer = textField.text == logo!.name
        
        if isCorrectAnswer {
            imageView.image = UIImage(systemName: "checkmark")
            
            // Add to user score
            store.addUserScore(amount: 10)
            
            // Update score in label
            updateScoreLabel()
            
            // Add answered question
            store.addAnsweredQuestion(logo!.name)
            
            delegate?.onCorrectAnswer?()
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if characterNumber == 0 {
            textField.text = logo!.name[characterNumber]
        } else {
            textField.text! += logo!.name[characterNumber]
        }
        
        characterNumber += 1
        
        checkAnswer()
    }

    @IBAction func resetTapped(_ sender: UIButton) {
        reset()
    }
}
