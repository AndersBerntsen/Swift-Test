//
//  MainMenu.swift
//  Swift Test
//
//  Created by Anders Berntsen on 10/08/2020.
//  Copyright © 2020 Anders Berntsen. All rights reserved.
//

import UIKit
import CoreData

class MainMenu: UIViewController {
    
    @IBOutlet var historyBtn: UIButton!
    
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
            historyBtn.setTitle("Search History (\(results.count))", for: .normal)
        } catch let error as NSError {
            print ("Could not fetch! \(error)")
        }
    }

}
