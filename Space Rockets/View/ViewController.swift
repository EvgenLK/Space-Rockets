import UIKit
import SnapKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SettingViewParamRocketDelegate{

    let viewModelResponse = NetworkRocketResponse()
    let settingVC = SettingViewParamRocketController()
    let viewModel = ViewModelResponseRocket()
    let viewModelparametrRocket = ViewModelCollectionView()
    let viewModelHelper = ViewModelHelper()
    var viewModelProtocol: CollectionViewModel?
    var viewRocketParamData = [DataRocket.ParamRocket]()
    var dictionaryRocket: [String: String] = [:]
    var ArrayRocketParam = ["Высота","Диаметр","Масса","Нагрузка"]
    var indexPageControl = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        settingVC.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        viewModelResponse.getDataRocketNetwork { json in
            self.viewModel.processJSONData()
            self.updateUI()
            self.viewModelparametrRocket.processJSONData()
            self.updateCell()
        }
        setupView()
        constraints()
    }
    
    func didSelectPage() {
        DispatchQueue.main.async {
            let tappedPageIndex = self.pageControl.currentPage
            self.indexPageControl = tappedPageIndex
            self.updateCell()
            self.updateUI()
        }
    }
    
    func didUpdateRocketParameters(height: Int, diameter: Int, mass: Int, leo: Int) {
                if let newHeightUnit = MeasurementUnit(rawValue: height) {
                    viewModelparametrRocket.currentHeightUnit = newHeightUnit
                }
                if let newDiameterUnit = DiameterUnit(rawValue: diameter) {
                    viewModelparametrRocket.currentDiameterUnit = newDiameterUnit
                }
                if let newMassUnit = WeightUnit(rawValue: mass) {
                    viewModelparametrRocket.currentWeightUnit = newMassUnit
                }
                if let newLeoUnit = LeoUnit(rawValue: leo) {
                    viewModelparametrRocket.currentLeoUnit = newLeoUnit
                }
                viewModelparametrRocket.processJSONData()
                updateCell()
    }
    
    func updateCell() {
        let rocketParametr = viewModelparametrRocket.getRocketDataParametr()
        guard indexPageControl < rocketParametr.count else {
            print("Ошибка: Индекс выходит за пределы допустимого диапазона для массива rocketParametr")
            return
        }
        
        DispatchQueue.main.async {
            self.viewRocketParamData = [rocketParametr[self.indexPageControl]]
            self.collectionView.reloadData()
        }
    }
    
    func updateUI() {
        let rocketInfo = viewModel.getRocketDataInfo()
        let rocketData = viewModel.getRocketDataData()
        DispatchQueue.main.async {
            if self.indexPageControl < rocketInfo.count {
                let rocket = rocketInfo[self.indexPageControl]
                self.dateOneStart.text = self.viewModelHelper.formatDate(dateString: rocket.dateOneStart)
                self.country.text = rocket.country
                self.startupCost.text = "$" + self.viewModelHelper.convertToMillions(inputNumber: "\(rocket.startupCost)") + " млн"
                self.firstStageNumberOfEngines.text = rocket.firstStageNumberOfEngines
                self.firstStageBurnTimeInSeconds.text = "\(rocket.firstStageBurnTimeInSeconds) sec"
                self.firstStageQuantitOfFuelInTons.text = "\(rocket.firstStageQuantitOfFuelInTons) ton."
                self.secondStageNumberOfEngines.text = rocket.secondStageNumberOfEngines
                self.secondStageBurnTimeInSeconds.text = "\(rocket.secondStageBurnTimeInSeconds) sec"
                self.secondStageQuantitOfFuelInTons.text = "\(rocket.secondStageQuantitOfFuelInTons) ton."
            }
            
            if self.indexPageControl < rocketData.count {
                let rocket = rocketData[self.indexPageControl]
                self.labelName.text = rocket.name
                self.viewModelHelper.loadImage(from: rocket.imageView ?? "rocket", into: self.imageRocket) // нужны рандомные картинки потом
            }
        }
    }
    
    func setupView() {
        view.addSubview(scrollInfoRocket)
        scrollInfoRocket.addSubview(contentView)
        contentView.addSubview(imageRocket)
        contentView.addSubview(blackView)
        blackView.addSubview(settingButtonIcon)
        blackView.addSubview(labelName)
        blackView.addSubview(collectionView)
        blackView.addSubview(labelDateOneStart)
        blackView.addSubview(dateOneStart)
        blackView.addSubview(labelCountry)
        blackView.addSubview(country)
        blackView.addSubview(labelStartupCost)
        blackView.addSubview(startupCost)
        blackView.addSubview(labelFirstStep)
        blackView.addSubview(labelFirstStageNumberOfEngines)
        blackView.addSubview(firstStageNumberOfEngines)
        blackView.addSubview(labelFirstStageQuantitOfFuelInTons)
        blackView.addSubview(firstStageQuantitOfFuelInTons)
        blackView.addSubview(labelFirstStageBurnTimeInSeconds)
        blackView.addSubview(firstStageBurnTimeInSeconds)
        blackView.addSubview(labelSecondStep)
        blackView.addSubview(labelSecondStageNumberOfEngines)
        blackView.addSubview(secondStageNumberOfEngines)
        blackView.addSubview(labelSecondStageQuantitOfFuelInTons)
        blackView.addSubview(secondStageQuantitOfFuelInTons)
        blackView.addSubview(labelSecondStageBurnTimeInSeconds)
        blackView.addSubview(secondStageBurnTimeInSeconds)
        blackView.addSubview(buttonToViewLaunches)
        view.addSubview(pageControl)
    }
     

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        pageControl.backgroundColor = .systemFill
        pageControl.addTarget(self, action: #selector(tapPageControl), for: .valueChanged)
        
        return pageControl
    }()
       
      @objc func tapPageControl() {
          didSelectPage()
      }
       
        let scrollInfoRocket: UIScrollView = {
           let scrollInfoRocket = UIScrollView()
           scrollInfoRocket.translatesAutoresizingMaskIntoConstraints = false
           scrollInfoRocket.backgroundColor = .white
           return scrollInfoRocket
       }()
       
        let contentView: UIView = {
           let contentView = UIView()
           contentView.translatesAutoresizingMaskIntoConstraints = false
           return contentView
       }()
       
    var imageRocket: UIImageView = {
           let imageRocket = UIImageView()
           imageRocket.translatesAutoresizingMaskIntoConstraints = false
           imageRocket.image = UIImage(named: "rocket")
           return imageRocket
       }()
       
        let blackView: UIView = {
           let blackView = UIView()
           blackView.translatesAutoresizingMaskIntoConstraints = false
           blackView.backgroundColor = .black
           blackView.layer.cornerRadius = 30
           return blackView
       }()
       
        lazy var settingButtonIcon: UIButton = {
           let settingButtonIcon = UIButton()
           settingButtonIcon.translatesAutoresizingMaskIntoConstraints = false
           settingButtonIcon.setImage(UIImage(named: "Setting.png"), for: .normal)
           settingButtonIcon.addTarget(self, action: #selector(viewSettingParamRocket), for: .touchUpInside)
           return settingButtonIcon
       }()
       
       @objc func viewSettingParamRocket() {
           let settingParamRocket = SettingViewParamRocketController()
           settingParamRocket.delegate = self
               present(settingParamRocket, animated: true)
       }
       
    let labelName: UILabel = {
           let labelName = UILabel()
           labelName.translatesAutoresizingMaskIntoConstraints = false
           labelName.font = UIFont(name: "Lab Grotesque", size: 24)
           labelName.font = UIFont.systemFont(ofSize: 32, weight: .bold)
           labelName.textColor = .white
           labelName.text = ""
           return labelName
       }()
       
    let collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           layout.scrollDirection = .horizontal
           cv.showsHorizontalScrollIndicator = false
           cv.backgroundColor = .black
           
           return cv
       }()
       
    let labelDateOneStart: UILabel = {
           let labelDateOneStart = UILabel()
           labelDateOneStart.translatesAutoresizingMaskIntoConstraints = false
           labelDateOneStart.font = UIFont(name: "Lab Grotesque", size: 16)
           labelDateOneStart.textColor = .white
           labelDateOneStart.text = "Первый запуск"
           return labelDateOneStart
       }()
       
    let dateOneStart: UILabel = {
           let dateOneStart = UILabel()
           dateOneStart.translatesAutoresizingMaskIntoConstraints = false
           dateOneStart.font = UIFont(name: "Lab Grotesque", size: 16)
           dateOneStart.textColor = .white
           dateOneStart.textAlignment = .center
           dateOneStart.text = ""
           return dateOneStart
       }()
       
    let labelCountry: UILabel = {
           let labelCountry = UILabel()
           labelCountry.translatesAutoresizingMaskIntoConstraints = false
           labelCountry.font = UIFont(name: "Lab Grotesque", size: 16)
           labelCountry.textColor = .white
           labelCountry.text = "Страна"
           return labelCountry
       }()
       
    let country: UILabel = {
           let country = UILabel()
           country.translatesAutoresizingMaskIntoConstraints = false
           country.font = UIFont(name: "Lab Grotesque", size: 16)
           country.textColor = .white
           country.text = ""
           country.textAlignment = .right
           
           return country
       }()
       
    let labelStartupCost: UILabel = {
           let labelStartupCost = UILabel()
           labelStartupCost.translatesAutoresizingMaskIntoConstraints = false
           labelStartupCost.font = UIFont(name: "Lab Grotesque", size: 16)
           labelStartupCost.textColor = .white
           labelStartupCost.text = "Стоимость запуска"
           return labelStartupCost
       }()
       
    let startupCost: UILabel = {
           let startupCost = UILabel()
           startupCost.translatesAutoresizingMaskIntoConstraints = false
           startupCost.font = UIFont(name: "Lab Grotesque", size: 16)
           startupCost.textColor = .white
           startupCost.text = ""
           startupCost.textAlignment = .center
           return startupCost
       }()
       
    let labelFirstStep: UILabel = {
           let labelFirstStep = UILabel()
           labelFirstStep.translatesAutoresizingMaskIntoConstraints = false
           labelFirstStep.font = UIFont(name: "Lab Grotesque", size: 16)
           labelFirstStep.textColor = .white
           labelFirstStep.font = UIFont.systemFont(ofSize: 24, weight: .bold)
           labelFirstStep.text = "Первая ступень"
           return labelFirstStep
       }()
       
    let labelFirstStageNumberOfEngines: UILabel = {
           let labelFirstStageNumberOfEngines = UILabel()
           labelFirstStageNumberOfEngines.translatesAutoresizingMaskIntoConstraints = false
           labelFirstStageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
           labelFirstStageNumberOfEngines.textColor = .white
           labelFirstStageNumberOfEngines.text = "Количесво двигателей"
           return labelFirstStageNumberOfEngines
       }()
       
    let firstStageNumberOfEngines: UILabel = {
           let firstStageNumberOfEngines = UILabel()
           firstStageNumberOfEngines.translatesAutoresizingMaskIntoConstraints = false
           firstStageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
           firstStageNumberOfEngines.textColor = .white
           firstStageNumberOfEngines.text = ""
           firstStageNumberOfEngines.textAlignment = .center
           return firstStageNumberOfEngines
       }()
       
    let labelFirstStageQuantitOfFuelInTons: UILabel = {
           let labelFirstStageQuantitOfFuelInTons = UILabel()
           labelFirstStageQuantitOfFuelInTons.translatesAutoresizingMaskIntoConstraints = false
           labelFirstStageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
           labelFirstStageQuantitOfFuelInTons.textColor = .white
           labelFirstStageQuantitOfFuelInTons.text = "Количесво топлива"
           return labelFirstStageQuantitOfFuelInTons
       }()
       
    let firstStageQuantitOfFuelInTons: UILabel = {
           let firstStageQuantitOfFuelInTons = UILabel()
           firstStageQuantitOfFuelInTons.translatesAutoresizingMaskIntoConstraints = false
           firstStageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
           firstStageQuantitOfFuelInTons.textColor = .white
           firstStageQuantitOfFuelInTons.text = ""
           firstStageQuantitOfFuelInTons.textAlignment = .center
           return firstStageQuantitOfFuelInTons
       }()
       
    let labelFirstStageBurnTimeInSeconds: UILabel = {
           let labelFirstStageBurnTimeInSeconds = UILabel()
           labelFirstStageBurnTimeInSeconds.translatesAutoresizingMaskIntoConstraints = false
           labelFirstStageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
           labelFirstStageBurnTimeInSeconds.textColor = .white
           labelFirstStageBurnTimeInSeconds.text = "Время сгорания"
           return labelFirstStageBurnTimeInSeconds
       }()
       
    let firstStageBurnTimeInSeconds: UILabel = {
           let firstStageBurnTimeInSeconds = UILabel()
           firstStageBurnTimeInSeconds.translatesAutoresizingMaskIntoConstraints = false
           firstStageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
           firstStageBurnTimeInSeconds.textColor = .white
           firstStageBurnTimeInSeconds.text = ""
           firstStageBurnTimeInSeconds.textAlignment = .center
           return firstStageBurnTimeInSeconds
       }()
       
    let labelSecondStep: UILabel = {
           let labelSecondStep = UILabel()
           labelSecondStep.translatesAutoresizingMaskIntoConstraints = false
           labelSecondStep.font = UIFont(name: "Lab Grotesque", size: 16)
           labelSecondStep.textColor = .white
           labelSecondStep.font = UIFont.systemFont(ofSize: 24, weight: .bold)
           labelSecondStep.text = "Вторая ступень"
           return labelSecondStep
       }()
       
    let labelSecondStageNumberOfEngines: UILabel = {
           let StageNumberOfEngines = UILabel()
           StageNumberOfEngines.translatesAutoresizingMaskIntoConstraints = false
           StageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
           StageNumberOfEngines.textColor = .white
           StageNumberOfEngines.text = "Количесво двигателей"
           return StageNumberOfEngines
       }()
       
    let secondStageNumberOfEngines: UILabel = {
           let StageNumberOfEngines = UILabel()
           StageNumberOfEngines.translatesAutoresizingMaskIntoConstraints = false
           StageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
           StageNumberOfEngines.textColor = .white
           StageNumberOfEngines.text = ""
           StageNumberOfEngines.textAlignment = .center
           return StageNumberOfEngines
       }()
       
    let labelSecondStageQuantitOfFuelInTons: UILabel = {
           let StageQuantitOfFuelInTons = UILabel()
           StageQuantitOfFuelInTons.translatesAutoresizingMaskIntoConstraints = false
           StageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
           StageQuantitOfFuelInTons.textColor = .white
           StageQuantitOfFuelInTons.text = "Количесво топлива"
           return StageQuantitOfFuelInTons
       }()
       
    let secondStageQuantitOfFuelInTons: UILabel = {
           let StageQuantitOfFuelInTons = UILabel()
           StageQuantitOfFuelInTons.translatesAutoresizingMaskIntoConstraints = false
           StageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
           StageQuantitOfFuelInTons.textColor = .white
           StageQuantitOfFuelInTons.text = ""
           StageQuantitOfFuelInTons.textAlignment = .center
           return StageQuantitOfFuelInTons
       }()
       
    let labelSecondStageBurnTimeInSeconds: UILabel = {
           let StageBurnTimeInSeconds = UILabel()
           StageBurnTimeInSeconds.translatesAutoresizingMaskIntoConstraints = false
           StageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
           StageBurnTimeInSeconds.textColor = .white
           StageBurnTimeInSeconds.text = "Время сгорания"
           return StageBurnTimeInSeconds
       }()
       
    let secondStageBurnTimeInSeconds: UILabel = {
           let StageBurnTimeInSeconds = UILabel()
           StageBurnTimeInSeconds.translatesAutoresizingMaskIntoConstraints = false
           StageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
           StageBurnTimeInSeconds.textColor = .white
           StageBurnTimeInSeconds.text = ""
           StageBurnTimeInSeconds.textAlignment = .center
           return StageBurnTimeInSeconds
       }()
       
    lazy var buttonToViewLaunches: UIButton = {
           let buttonToViewLaunches = UIButton()
           buttonToViewLaunches.translatesAutoresizingMaskIntoConstraints = false
           buttonToViewLaunches.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
           buttonToViewLaunches.setTitle("Посмотреть запуски", for: .normal)
           buttonToViewLaunches.layer.cornerRadius = 20
           buttonToViewLaunches.backgroundColor = .systemGray
           buttonToViewLaunches.tintColor = .white
           buttonToViewLaunches.addTarget(self, action: #selector(viewListSpaceRocket), for: .touchUpInside)
           return buttonToViewLaunches
       }()
       
      @objc func viewListSpaceRocket() {
           let listSpaceRocket = TableListSpaceRocketController()
          navigationController?.pushViewController(listSpaceRocket, animated: true)
       }
       
       func constraints() {
           scrollInfoRocket.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
           
           contentView.snp.makeConstraints { make in
               make.edges.equalTo(scrollInfoRocket)
               make.width.equalTo(scrollInfoRocket)
           }
           
           imageRocket.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(-50)
               make.left.equalToSuperview()
               make.width.equalToSuperview()
               make.height.equalToSuperview().multipliedBy(0.4)
           }
           
           blackView.snp.makeConstraints { make in
               make.top.equalTo(imageRocket.snp.bottom).offset(-150)
               make.left.equalToSuperview()
               make.width.equalToSuperview()
               make.height.equalToSuperview().multipliedBy(0.8)
           }
           
           labelName.snp.makeConstraints { make in
               make.top.equalTo(blackView).offset(48)
               make.left.equalToSuperview().offset(32)
           }
           
           settingButtonIcon.snp.makeConstraints { make in
               make.top.equalTo(blackView).offset(48)
               make.right.equalToSuperview().offset(-32)
           }
           
           collectionView.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(112)
               make.left.equalToSuperview().offset(0)
               make.right.equalToSuperview().offset(0)
               make.height.equalTo(96)
           }

           labelDateOneStart.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(248)
               make.left.equalToSuperview().offset(32)
           }
           
           dateOneStart.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(248)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           labelCountry.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(288)
               make.left.equalToSuperview().offset(32)
           }
           
           country.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(288)
               make.right.equalToSuperview().offset(32)
   //            make.left.equalToSuperview().offset(233)
           }
           
           labelStartupCost.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(328)
               make.left.equalToSuperview().offset(32)
           }
           
           startupCost.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(328)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           labelFirstStep.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(392)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(32)
           }
           
           labelFirstStageNumberOfEngines.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(432)
               make.left.equalToSuperview().offset(32)
           }
           
           firstStageNumberOfEngines.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(432)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           labelFirstStageQuantitOfFuelInTons.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(472)
               make.left.equalToSuperview().offset(32)
           }
           
           firstStageQuantitOfFuelInTons.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(472)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           labelFirstStageBurnTimeInSeconds.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(512)
               make.left.equalToSuperview().offset(32)
           }
           
           firstStageBurnTimeInSeconds.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(512)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           labelSecondStep.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(576)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(32)
           }
           
           labelSecondStageNumberOfEngines.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(616)
               make.left.equalToSuperview().offset(32)
           }
           
           secondStageNumberOfEngines.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(616)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           labelSecondStageQuantitOfFuelInTons.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(656)
               make.left.equalToSuperview().offset(32)
           }
           
           secondStageQuantitOfFuelInTons.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(656)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           labelSecondStageBurnTimeInSeconds.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(696)
               make.left.equalToSuperview().offset(32)
           }
           
           secondStageBurnTimeInSeconds.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(696)
               make.right.equalToSuperview().offset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           buttonToViewLaunches.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(749)
               make.right.equalToSuperview().offset(-32)
               make.left.equalToSuperview().offset(32)
               make.height.equalTo(70)
           }
           
           pageControl.snp.makeConstraints { make in
               make.left.right.equalToSuperview()
               make.bottom.equalToSuperview()
               make.height.equalTo(72)
           }
           
       }
}
