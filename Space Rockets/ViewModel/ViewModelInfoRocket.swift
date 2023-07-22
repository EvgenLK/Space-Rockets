//
//  ViewModelInfoRocket.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 16.07.2023.
//

import Foundation

class ViewModelInfoRocket {
    
    let infoRocket  = DataRocket.InfoRocket(dateOneStart: "222", country: "222", startupCost: "222", firstStageNumberOfEngines: "222", firstStageQuantitOfFuelInTons: "222", firstStageBurnTimeInSeconds: "222", secondStageNumberOfEngines: "222", secondStageQuantitOfFuelInTons: "222", secondStageBurnTimeInSeconds: "222")
    
    var dateOneStart: String {
        return infoRocket.dateOneStart
    }
    
    var country: String {
        return infoRocket.country
    }
    
    var startupCost: String {
        return infoRocket.startupCost
    }
    
    var firstStageNumberOfEngines: String {
        return infoRocket.firstStageNumberOfEngines
    }
    
    var firstStageQuantitOfFuelInTons: String {
        return infoRocket.firstStageQuantitOfFuelInTons
    }
    
    var firstStageBurnTimeInSeconds: String {
        return infoRocket.firstStageBurnTimeInSeconds
    }
    
    var secondStageNumberOfEngines: String {
        return infoRocket.secondStageNumberOfEngines
    }
    
    var secondStageQuantitOfFuelInTons: String {
        return infoRocket.secondStageQuantitOfFuelInTons
    }
    
    var secondStageBurnTimeInSeconds: String {
        return infoRocket.secondStageBurnTimeInSeconds
    }
    

}
