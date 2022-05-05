//
//  SelectLevelViewController.swift
//  Logo Quiz App
//
//  Created by Hansel Matthew on 04/05/22.
//

import UIKit

class SelectLevelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var SelectLevelTable: UITableView!
    
    var items:[level] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dummy Data
        let level1:level = level(title: "Level1", progress: 9, maxProgress: 15, backgroundColor: .blue)
        let level2:level = level(title: "Level1", progress: 9, maxProgress: 15, backgroundColor: .red)
        items.append(level1)
        items.append(level2)
        
        
        let nib = UINib(nibName: "SelectLevelTableViewCell", bundle: nil)
        SelectLevelTable.register(nib, forCellReuseIdentifier: "SelectLevelTableViewCell")
        SelectLevelTable.delegate = self
        SelectLevelTable.dataSource = self
               
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectLevelTableViewCell", for: indexPath) as! SelectLevelTableViewCell
        
        let tableLevel = items[indexPath.row]
        
        cell.configure(tableLevel)
        
        cell.backgroundColor = tableLevel.backgroundColor
        
        return cell
    }

}
