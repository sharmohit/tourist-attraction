//
//  Session.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 03/04/21.
//

import Foundation

class Session {
    
    let usernamePasswordMap:[String:String] = ["thanos@gmail.com":"5555", "wonderwoman@yahoo.com":"abcd"]
    
    func isValidUsername(username:String) -> Bool {
        if usernamePasswordMap[username] != nil {
            return true
        }
        else
        {
            return false
        }
    }
    
    func login(username:String, password:String, isSaveLogin:Bool) -> Bool {
        
        for user in usernamePasswordMap {
            if username == user.key &&
                password == user.value {
                print("Login Success")
                print("Save login is \(isSaveLogin)")
                return true
            }
        }
        return false
    }
    
    func logout() {
        
    }
}
