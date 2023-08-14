//
//  SettingParamertUserDefaults.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 14.08.2023.
//

import Foundation

class SettingParamertUserDefaults {
    
    let userDefaultsSetting = UserDefaults.standard
    
    
    func saveUserSettingParametr(height: Int, diameter: Int, mass: Int, leo: Int) {
        
        UserDefaults.resetStandardUserDefaults()
        
        userDefaultsSetting.set(height, forKey: "height")
        userDefaultsSetting.set(diameter, forKey: "diameter")
        userDefaultsSetting.set(mass, forKey: "mass")
        userDefaultsSetting.set(leo, forKey: "leo")
        
    }
    
    func readUserSettingParametr(completion: @escaping (Int, Int, Int, Int) -> Void) {
        let height = userDefaultsSetting.integer(forKey: "height")
        let diameter = userDefaultsSetting.integer(forKey: "diameter")
        let mass = userDefaultsSetting.integer(forKey: "mass")
        let leo = userDefaultsSetting.integer(forKey: "leo")

        completion(height, diameter, mass, leo)
    }
    
    
    
    
}
