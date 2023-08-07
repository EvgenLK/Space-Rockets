//
//  ViewModelLaunchesList.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 06.08.2023.
//

import Foundation

class ViewModelLaunchesList: ViewModelTypeLaunches {
    
    let viewModelLaunches = NetworkLaunchesRocket()
    let ViewModelLaunchesData = ViewViewModelLaunchesList()
    var launchesListRocket = [LaunchesModel]()
    
    func responseLaunchesList(complition:@escaping(Any)->()) {
        viewModelLaunches.getLaunchesRocketNetwork { json in
            self.ViewModelLaunchesData.getLaunchesList(array: json) { launches in
                DispatchQueue.main.async {
                    self.launchesListRocket = launches
                    complition(self.launchesListRocket)
                }
            }
        }
    }
    
    func getLaunches() -> [LaunchesModel] {
        print(launchesListRocket)
        return self.launchesListRocket
    }
    
    func numberOfRows() -> Int {
        return launchesListRocket.count
    }
}
