//
//  SelectLevelViewController.swift
//  Logo Quiz App
//
//  Created by Hansel Matthew on 09/05/22.
//

import UIKit

class SelectLevelViewController: UIViewController
{
    @IBOutlet weak var logoSolved: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var data: Dictionary<Int, Level> = [:]
    
    var selectedLevel: Int = 0
    
    var levelControls: [LevelProgressControl] = []
    
    var store: UserCoreDataStore {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return UserCoreDataStore(context: context)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Select Level"
        let user = store.fetchUser()
        scrollView.delaysContentTouches = false
        
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
        
        let accentList: [UIColor] = [.purple, .red, .yellow, .blue, .gray, .green]
        var nextTopAnchor = scrollView.topAnchor
        for levelValue in data.keys.sorted()
        {
            let control = LevelProgressControl()
            
            control.layer.cornerRadius = 14
            control.layer.shadowRadius = 3
            control.layer.shadowOpacity = 0.4
            control.layer.shadowColor = UIColor.gray.cgColor
            control.layer.shadowOffset = CGSize(width: 0, height: 4)
            control.bgView.layer.cornerRadius = 14
            control.bgView.layer.masksToBounds = true
            
            control.addTarget(self, action: #selector(onLevelControl(_:)), for: .touchUpInside)
            scrollView.addSubview(control)
            levelControls.append(control)
            
            control.valueMax = data[levelValue]!.maxProgress
            control.valueNow = data[levelValue]!.progress
            control.level    = levelValue
            control.accentColor = accentList[levelValue % accentList.count]
            
            control.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                control.heightAnchor.constraint(equalToConstant: 100),
                control.topAnchor.constraint(equalTo: nextTopAnchor, constant: 12),
                control.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 12),
                control.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -12)
            ])
            nextTopAnchor = control.bottomAnchor
        }
        scrollView.bottomAnchor.constraint(equalTo: nextTopAnchor, constant: 32).isActive = true
        
        let solvedCount = data.values.reduce(0, { return Int($0.magnitude) + $1.progress })
        logoSolved.text = "Logo solved: \(solvedCount)"
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func onLevelControl(_ sender: LevelProgressControl)
    {
        selectedLevel = sender.level
        self.performSegue(withIdentifier: "goToCollection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "goToCollection")
        {
            guard let vc = segue.destination as? LogoCollectionViewController
            else { return }
            vc.delegate = self
            vc.selectedLevel = selectedLevel
        }
    }
}

extension SelectLevelViewController: LogoCollectionViewControllerDelegate
{
    func onCorrectAnswer(didAnswerItemAt level: Int)
    {
        let control = levelControls.first(where: { $0.level == level })
        control?.valueNow += 1
        
        let totalSolvedText = logoSolved.text?.components(separatedBy: ": ")[1] ?? ""
        let totalSolvedNow = Int(totalSolvedText) ?? 0
        logoSolved.text = "Logo solved: \(totalSolvedNow + 1)"
        
    }
}
