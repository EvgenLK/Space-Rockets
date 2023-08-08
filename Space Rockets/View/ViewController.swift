import UIKit
import SnapKit

final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let customViewRocket = CustomViewRosket()
    let viewModelResponse = NetworkRocketResponse()
    let viewModel = ViewModelResponseRocket()
    let viewModelparametrRocket = ViewModelCollectionView()
    let viewModelHelper = ViewModelHelper()
    var viewModelProtocol: CollectionViewModel?
    var viewRocketParamData = [DataRocket.ParamRocket]()
    var dictionaryRocket: [String: String] = [:]
    var ArrayRocketParam = ["Высота","Диаметр","Масса","Нагрузка"]
    
    override func loadView() {
        view = customViewRocket
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        customViewRocket.collectionView.delegate = self
        customViewRocket.collectionView.dataSource = self
        customViewRocket.viewController = self
        customViewRocket.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        viewModelResponse.getDataRocketNetwork { json in
            self.viewModel.processJSONData()
            self.updateUI()
            self.viewModelparametrRocket.processJSONData()
            self.updateCell()
        }
    }
    
    func updateCell() {
        let rocketParametr = viewModelparametrRocket.getRocketDataParametr()
        DispatchQueue.main.async {
            self.viewRocketParamData = [rocketParametr[0]]
            self.customViewRocket.collectionView.reloadData()
        }
    }
    
    func updateUI() {
        
        let rocketInfo = viewModel.getRocketDataInfo()
        let rocketData = viewModel.getRocketDataData()
        
        DispatchQueue.main.async {
            if let rocket = rocketInfo.first {
                self.customViewRocket.dateOneStart.text = self.viewModelHelper.formatDate(dateString: rocket.dateOneStart)
                self.customViewRocket.country.text = rocket.country
                self.customViewRocket.startupCost.text = "$" + self.viewModelHelper.convertToMillions(inputNumber: "\(rocket.startupCost)") + " млн"
                self.customViewRocket.firstStageNumberOfEngines.text = rocket.firstStageNumberOfEngines
                self.customViewRocket.firstStageBurnTimeInSeconds.text = "\(rocket.firstStageBurnTimeInSeconds) sec"
                self.customViewRocket.firstStageQuantitOfFuelInTons.text = "\(rocket.firstStageQuantitOfFuelInTons) ton."
                self.customViewRocket.secondStageNumberOfEngines.text = rocket.secondStageNumberOfEngines
                self.customViewRocket.secondStageBurnTimeInSeconds.text = "\(rocket.secondStageBurnTimeInSeconds) sec"
                self.customViewRocket.secondStageQuantitOfFuelInTons.text = "\(rocket.secondStageQuantitOfFuelInTons) ton."
            }
            
            if let rocket = rocketData.first {
                self.customViewRocket.labelName.text = rocket.name
                self.viewModelHelper.loadImage(from: rocket.imageView ?? "rocket", into: self.customViewRocket.imageRocket)
            }
        }
    }
}
