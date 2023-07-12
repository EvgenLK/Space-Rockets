//
//  ViewModel.swift
//  Space Rockets
//
//  Created by Evgenii Kutasov on 10.07.2023.
//

import Foundation

class ViewModelRocket {
    
    private var rocketName = dataRocket(imageView: "https://i.imgur.com/DaCfMsj.jpg", name: "Falcon 1")
    
    var imageView: String {
        return rocketName.imageView
    }
    
    var name: String {
        return rocketName.name
    }
    
    private var rocketParam = dataRocket.ParamRocket(height: "1", diameter: "1", weight: "1", leo: "1")
    
    var height: String {
        return rocketParam.height
    }
    
    var diameter: String {
        return rocketParam.diameter
    }
    
    var weight: String {
        return rocketParam.weight
    }
    
    var leo: String {
        return rocketParam.leo
    }
    
    private var rocketInfo = dataRocket.infoRocket(dateOneStart: "1", country: "1", startupCost: "1", firstStageNumberOfEngines: "1", firstStageQuantitOfFuelInTons: "1", firstStageBurnTimeInSeconds: "1", secondStageNumberOfEngines: "1", secondStageQuantitOfFuelInTons: "1", secondStageBurnTimeInSeconds: "1")
    
    var dateOneStart: String {
        return rocketInfo.dateOneStart
    }
    
    var country: String {
        return rocketInfo.country
    }
    
    var startupCost: String {
        return rocketInfo.startupCost
    }
    
    var firstStageNumberOfEngines: String {
        return rocketInfo.firstStageNumberOfEngines
    }
    
    var firstStageQuantitOfFuelInTons: String {
        return rocketInfo.firstStageQuantitOfFuelInTons
    }
    
    var firstStageBurnTimeInSeconds: String {
        return rocketInfo.firstStageBurnTimeInSeconds
    }
    
    var secondStageNumberOfEngines: String {
        return rocketInfo.secondStageNumberOfEngines
    }
    
    var secondStageQuantitOfFuelInTons: String {
        return rocketInfo.secondStageQuantitOfFuelInTons
    }
    
    var secondStageBurnTimeInSeconds: String {
        return rocketInfo.secondStageBurnTimeInSeconds
    }
}
