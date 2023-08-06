//
//  ViewModelLaunchesList.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 06.08.2023.
//

import Foundation

class ViewModelLaunchesList: ViewModelTypeLaunches {
    
    let viewModelLaunches = NetworkLaunchesRocket()
    let ViewModelLaunchesData = ViewViewModelLaunchesList() // Corrected class name
    private var selectedIndexPath: IndexPath?
    
    var launchesListRocket = [LaunchesModel]() // Corrected array type to [LaunchesModel]

    func responseLaunchesList() {
        viewModelLaunches.getLaunchesRocketNetwork { json in
            self.ViewModelLaunchesData.getLaunchesList(array: json) { launches in
                DispatchQueue.main.async {
                    self.launchesListRocket = launches
                }
            }
        }
    }
    
    func getLaunches() -> [LaunchesModel] { // Corrected return type to [LaunchesModel]
        return launchesListRocket
    }
    
    func numberOfRows() -> Int {
        return launchesListRocket.count
    }
    
}
