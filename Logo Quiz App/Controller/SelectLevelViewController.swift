//
//  SelectLevelViewController.swift
//  Logo Quiz App
//
//  Created by Hansel Matthew on 04/05/22.
//

import UIKit

class SelectLevelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    @IBOutlet weak var SelectLevelTable: UITableView!
    
    var data: Dictionary<Int, Level> = [:]
    
    let bgColorList: [UIColor] = [ .green, .blue, .purple, .red, .orange, .brown ]
    
    var store: UserCoreDataStore {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return UserCoreDataStore(context: context)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        
        let nib = UINib(nibName: "SelectLevelTableViewCell", bundle: nil)
        SelectLevelTable.register(nib, forCellReuseIdentifier: "SelectLevelTableViewCell")
        SelectLevelTable.delegate = self
        SelectLevelTable.dataSource = self
               
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "goToCollection")
        {
            guard let vc = segue.destination as? LogoCollectionViewController
            else { return }
            vc.selectedLevel = SelectLevelTable.indexPathForSelectedRow?.row
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectLevelTableViewCell", for: indexPath) as! SelectLevelTableViewCell
        
        let tableLevel = data[indexPath.row]!
        
        cell.configure(tableLevel)
        
        cell.backgroundColor = tableLevel.backgroundColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToCollection", sender: self)
    }

}
