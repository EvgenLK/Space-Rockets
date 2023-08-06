
class ViewViewModelLaunchesList {
    
    var launchesList = [LaunchesModel]()
    
    func getLaunchesList(array: Any, complition:@escaping([LaunchesModel]) -> ()) {
        guard let array = array as? [[String: Any]] else { return }
        
        for result in array {
            guard let name = result["name"] as? String,
                  let launchesSuccess = result["success"] as? String,
                  let date = result["staticFireDateUTC"] as? String else {
                continue
            }
            
            let launches = LaunchesModel(name: name, success: launchesSuccess, staticFireDateUTC: date)
            launchesList.append(launches)
        }
        complition(launchesList)
    }
}
