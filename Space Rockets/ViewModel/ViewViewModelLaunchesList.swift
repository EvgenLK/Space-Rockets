
class ViewViewModelLaunchesList {
    
    var launchesList = [LaunchesModel]()
    
    func getLaunchesList(array: Any, complition: @escaping ([LaunchesModel]) -> ()) {
        guard let array = array as? [[String: Any]] else { return }
        
        var names: String = ""
        for result in array {
            if let name = result["name"] as? String {
                if name != nil {
                    names = name
                } else {
                    names = "Данные отсутствуют"
                }
            }
            var imageSuccesss: String = ""
            if let imageSuccess = result["success"] as? Int {
                if imageSuccess == 1 {
                    imageSuccesss = "successLaunches.png"
                } else {
                    imageSuccesss = "failedLaunches.jpg"
                }
            }
            let date = result["static_fire_date_utc"] as? String ?? "Данные отсутствуют"
            let launches = LaunchesModel(name: names, imageSuccess: imageSuccesss, staticFireDateUTC: date)
            launchesList.append(launches)
        }
        
        complition(launchesList)
    }
}
