//
//  SearchView Controller.swift
//  Swift Test
//
//  Created by Anders Berntsen on 10/08/2020.
//  Copyright © 2020 Anders Berntsen. All rights reserved.
//

import UIKit
import CoreData

class SearchView_Controller: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    let baseURL: String = "https://robohash.org/"
    struct Robot {
        var image: UIImage?
        var searchText: String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let requestUrl = URL(string: baseURL + searchText) else {
            return
        }
        if searchText.isEmpty {
            return
        }
        downloadImage(from: requestUrl)
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            let robot = Robot(image: UIImage(data: data), searchText: String(url.absoluteString.split(separator: "/")[2]))
            
            DispatchQueue.main.async { [weak self] in
                self?.save(robot: robot)
                self?.imageView.image = UIImage(data: data)
                self?.resultLabel.text = robot.searchText
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func save(robot: Robot) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Robot", in: managedContext)!
        let robotObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        robotObject.setValue(robot.searchText, forKey: "searchText")
        
        let imageData = robot.image?.pngData()
        robotObject.setValue(imageData, forKey: "image")
        
        do {
            try managedContext.save()
            print("Saved to Core data")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
