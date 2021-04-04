//
//  AttractionsViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class AttractionsViewController: UIViewController {

    var attractions:[Attraction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadAttractions() {
        if let filepath = Bundle.main.path(forResource:"attractions", ofType:"json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = contents.data(using: .utf8)!
                let attractions:[Attraction] = try! JSONDecoder().decode([Attraction].self, from:jsonData)
                
                for attraction in attractions {
                    self.attractions.append(attraction)
                    print("\(attraction.name)")
                }
            } catch {
                print("Cannot load file")
            }
        } else {
            print("File not found")
        }
    }
}
