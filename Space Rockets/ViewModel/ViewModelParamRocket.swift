//
//  ViewModelParamRocket.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 16.07.2023.
//

import Foundation

class ViewModelParamRocket {
    
    private let paramRocket: ParamRocket
    
    var height: String {
        return paramRocket.height
    }
    
    var diameter: String {
        return paramRocket.diameter
    }
    
    var weight: String {
        return paramRocket.weight
    }
    
    var leo: String {
        return paramRocket.leo
    }
    
    init(paramRocket: ParamRocket) {
        self.paramRocket = paramRocket
    }
    
}
