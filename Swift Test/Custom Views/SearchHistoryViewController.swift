//
//  SearchHistoryViewController.swift
//  Swift Test
//
//  Created by Anders Berntsen on 10/08/2020.
//  Copyright © 2020 Anders Berntsen. All rights reserved.
//

import UIKit
import CoreData

class SearchHistoryViewController: UITableViewController {

    var robots: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Robot")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            for result in results {
                
                robots.append(result)
            }
            print(robots)
        } catch let error as NSError {
            print ("Could not fetch! \(error)")
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return robots.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.rowHeight = 120.0
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        let robot = robots[indexPath.row]
        
        cell.searchText.text = robot.value(forKey: "searchText") as? String
        
        let image = robot.value(forKey: "image")
        cell.profileImg.image = UIImage(data: image as! Data)
                
        return cell
    }
}
