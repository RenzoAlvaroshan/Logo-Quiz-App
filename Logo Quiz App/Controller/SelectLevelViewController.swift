//
//  SelectLevelViewController.swift
//  Logo Quiz App
//
//  Created by Hansel Matthew on 09/05/22.
//

import UIKit

class SelectLevelViewController: UIViewController {
    
    
    @IBOutlet weak var level1Progress: UILabel!
    @IBOutlet weak var level1Percentage: UILabel!
    @IBOutlet weak var level2Progress: UILabel!
    @IBOutlet weak var level2Percentage: UILabel!
    @IBOutlet weak var level3Progress: UILabel!
    @IBOutlet weak var level3Percentage: UILabel!
    @IBOutlet weak var level4Progress: UILabel!
    @IBOutlet weak var level4Percentage: UILabel!
    
    @IBOutlet weak var level1Color: UIView!
    @IBOutlet weak var level2Color: UIView!
    @IBOutlet weak var level3Color: UIView!
    @IBOutlet weak var level4Color: UIView!
    
    @IBOutlet weak var logoSolved: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var data: Dictionary<Int, Level> = [:]
    
    var selectedLabel: Int = 0
    
    var store: UserCoreDataStore {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return UserCoreDataStore(context: context)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        logoSolved.layer.cornerRadius = 12
        logoSolved.layer.masksToBounds = true
        //        scrollView.layer.cornerRadius = 33

        configureButtonColor(level1Color)
        configureButtonColor(level2Color)
        configureButtonColor(level3Color)
        configureButtonColor(level4Color)
        
        self.title = "Select Level"
        let user = store.fetchUser()
        
        let view = CoinView(frame: CGRect(x: 0, y: 0, width: 72, height: 27))
        view.coinValue = Int(user?.score ?? 0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
        
        Logo.list.forEach() { logo in
                    var level = data[logo.level] ?? Level(title: logo.level, progress: 0, maxProgress: 0, backgroundColor: .white)
                    let isAnswered = user?.answeredQuestions?.contains(logo.name) ?? false
                    level.maxProgress += 1
                    level.progress += isAnswered ? 1 : 0
                    data[logo.level] = level
                }
        
        level1Progress.text = data[0]?.getProgressString()
        level1Percentage.text = data[0]?.getPercentageString()
        
        level2Progress.text = data[1]?.getProgressString()
        level2Percentage.text = data[1]?.getPercentageString()
        
        level3Progress.text = data[2]?.getProgressString()
        level3Percentage.text = data[2]?.getPercentageString()
 
    }
    
    
    @IBAction func levelButtonPressed(_ sender: UIButton) {
        selectedLabel =  Int((sender.titleLabel?.text)!)!
        self.performSegue(withIdentifier: "goToCollection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if (segue.identifier == "goToCollection")
            {
                guard let vc = segue.destination as? LogoCollectionViewController
                else { return }
                vc.selectedLevel = selectedLabel + 1
            }
        }

    func configureButtonColor(_ selectColor: UIView){
        selectColor.clipsToBounds = true
        selectColor.layer.cornerRadius = 5
        selectColor.layer.maskedCorners =  [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
}
