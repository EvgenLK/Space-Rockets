//
//  ViewModelCollectionView.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 25.07.2023.
//

import Foundation

class ViewModelCollectionView: CollectionViewModel {
    
    let viewModelResponse = NetworkRocketResponse()
    private var rocketParam = [SpaceDatumRocket]()
    var rocketParamData = [DataRocket.ParamRocket]()
    
    var currentHeightUnit: MeasurementUnit = .meters
    var currentWeightUnit: WeightUnit = .kilograms
    var currentDiameterUnit: DiameterUnit = .meters
    var currentLeoUnit: LeoUnit = .lb
    

    init() {
        fetchRocketData()
    }

    private func fetchRocketData() {
        viewModelResponse.getDataRocketNetwork { json in
            self.rocketParam = json
        }
    }
    
    func processJSONData() {
         for rocketData in self.rocketParam {
             var heightValue: String
             var weightValue: String
             var diameterValue: String
             var leoValue: String

             switch currentHeightUnit {
             case .feet:
                  heightValue = "\(rocketData.height.feet ?? 0)"
             case .meters:
                  heightValue = "\(rocketData.height.meters ?? 0)"
             }
             
             switch currentDiameterUnit {
             case .feet:
                  diameterValue = "\(rocketData.diameter.feet ?? 0)"
             case .meters:
                  diameterValue = "\(rocketData.diameter.meters ?? 0)"
             }
             
             switch currentWeightUnit {
             case .kilograms:
                  weightValue = "\(rocketData.mass.kg)"
             case .lb:
                  weightValue = "\(rocketData.mass.lb)"
             }
             
             switch currentLeoUnit {
             case .kilograms:
                  leoValue = "\(rocketData.payloadWeights[0].kg)"
             case .lb:
                  leoValue = "\(rocketData.payloadWeights[0].lb)"
             }
             
             let rocketParametr = DataRocket.ParamRocket(height: heightValue, diameter: diameterValue, weight: weightValue, leo: leoValue)
             rocketParamData.append(rocketParametr)
        }
    }
    
    func getRocketDataParametr() -> [DataRocket.ParamRocket] {
        return rocketParamData
    }

    func numberOfRows() -> Int {
        return rocketParamData.count
    }

}

