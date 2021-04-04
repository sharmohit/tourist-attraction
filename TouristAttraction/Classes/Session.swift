//
//  Session.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 03/04/21.
//

import Foundation

class Session {
    
    let defaults = UserDefaults.standard
    let usernamePasswordMap:[String:String] = ["thanos@gmail.com":"5555", "wonderwoman@yahoo.com":"abcd"]
    
    func initiateLogin() -> Bool {
        
        let username = defaults.string(forKey:"user") ?? ""
        let password = defaults.string(forKey:"pass") ?? ""
        
        if username != "" &&
            password != "" {
            return self.login(username:username, password:password, isSaveLogin:true)
        }
        
        return false
    }
    
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
                if isSaveLogin {
                    defaults.set(username, forKey:"user")
                    defaults.set(password, forKey:"pass")
                }
                return true
            }
        }
        return false
    }
    
    func logout() {
        defaults.set("", forKey:"user")
        defaults.set("", forKey:"pass")
    }
}
