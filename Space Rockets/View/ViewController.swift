import UIKit
import SnapKit

final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  DelegateTappedPage {
    
    let customViewRocket = CustomViewRosket()
    let viewModelResponse = NetworkRocketResponse()
    let viewModel = ViewModelResponseRocket()
    let viewModelparametrRocket = ViewModelCollectionView()
    let viewModelHelper = ViewModelHelper()
    var viewModelProtocol: CollectionViewModel?
    var viewRocketParamData = [DataRocket.ParamRocket]()
    var dictionaryRocket: [String: String] = [:]
    var ArrayRocketParam = ["Высота","Диаметр","Масса","Нагрузка"]
    var indexPageControl = 0
    
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
        customViewRocket.delegate = self
        customViewRocket.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        viewModelResponse.getDataRocketNetwork { json in
            self.viewModel.processJSONData()
            self.updateUI()
            self.viewModelparametrRocket.processJSONData()
            self.updateCell()
        }
    }
        
    func didSelectPage(number: Int) {
        self.indexPageControl = number
        updateCell()
        updateUI()
    }
    
    func updateCell() {
        let rocketParametr = viewModelparametrRocket.getRocketDataParametr()
        DispatchQueue.main.async {
            self.viewRocketParamData = [rocketParametr[self.indexPageControl]]
            self.customViewRocket.collectionView.reloadData()
        }
    }
    
    func updateUI() {
        let rocketInfo = viewModel.getRocketDataInfo()
        let rocketData = viewModel.getRocketDataData()
        DispatchQueue.main.async {
            if self.indexPageControl < rocketInfo.count {
                let rocket = rocketInfo[self.indexPageControl]
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
            
            if self.indexPageControl < rocketData.count {
                let rocket = rocketData[self.indexPageControl]
                self.customViewRocket.labelName.text = rocket.name
                self.viewModelHelper.loadImage(from: rocket.imageView ?? "rocket", into: self.customViewRocket.imageRocket) // нужны рандомные картинки потом
            }
        }
    }
}
