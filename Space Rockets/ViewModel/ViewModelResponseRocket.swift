//
//  ViewModelResponseRocket.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 23.07.2023.
//

import Foundation
import UIKit

class ViewModelResponseRocket {
    
    private var rocketInfo: [DataRocket.InfoRocket] = []
    private var rocketDataData: [DataRocket] = []
    private var viewModelResponseRocket = NetworkRocketResponse()
    var dataRocket = [SpaceDatumRocket]()
    
    
    init() {
        fetchRocketData()
    }

    private func fetchRocketData() {
        viewModelResponseRocket.getDataRocketNetwork { json in
            self.dataRocket = json
        }
    }
    
    func processJSONData() {
        for rocketData in self.dataRocket {
            let rocketInfoVM = DataRocket.InfoRocket(dateOneStart: "\(rocketData.firstFlight)",
                                                     country: "\(rocketData.country)",
                                                     startupCost: "\(rocketData.costPerLaunch)",
                                                     firstStageNumberOfEngines: "\(rocketData.firstStage.engines)",
                                                     firstStageQuantitOfFuelInTons: "\(rocketData.firstStage.fuelAmountTons)",
                                                     firstStageBurnTimeInSeconds: "\(rocketData.firstStage.burnTimeSEC ?? 0)",
                                                     secondStageNumberOfEngines: "\(rocketData.secondStage.engines)",
                                                     secondStageQuantitOfFuelInTons: "\(rocketData.secondStage.fuelAmountTons)",
                                                     secondStageBurnTimeInSeconds: "\(rocketData.secondStage.burnTimeSEC ?? 0)")
            rocketInfo.append(rocketInfoVM)
               
            let rocketDataVM = DataRocket(imageView: rocketData.flickrImages.first, name: rocketData.name) 
            rocketDataData.append(rocketDataVM)
        }
    }
    
    func getRocketDataInfo() -> [DataRocket.InfoRocket] {
        return rocketInfo
    }

    func getRocketDataData() -> [DataRocket] {
        return rocketDataData
    }
    
    func getRocket(at index: Int) -> DataRocket? {
        guard index >= 0, index < rocketDataData.count else {
            return nil
        }
        return rocketDataData[index]
    }

}
    

