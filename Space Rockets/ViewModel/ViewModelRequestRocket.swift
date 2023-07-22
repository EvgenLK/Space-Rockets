import Foundation

class ViewModelRequestRocket {
    
    public func getDataRocket(completion: (Any) -> ()) {
        let session = URLSession.shared

        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
