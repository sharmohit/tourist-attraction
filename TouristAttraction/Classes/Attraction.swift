//
//  Attraction.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import Foundation

struct Attraction : Codable {
    let name:String
    let description:String
    let icon:String
    let photos:[String]
    let address:String
    let phone:String
    let website:String
    let price:String
    
    init()
    {
        self.name = ""
        self.description = ""
        self.icon = ""
        self.photos = []
        self.address = ""
        self.phone = ""
        self.website = ""
        self.price = ""
    }
}
