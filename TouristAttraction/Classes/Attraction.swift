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
}
