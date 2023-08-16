import UIKit
import SnapKit

final class MainRocketScreenView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SettingViewParamRocketDelegate{

    let viewModelResponse = NetworkRocketResponse()
    let viewModel = ViewModelResponseRocket()
    let viewModelparametrRocket = ViewModelCollectionView()
    let viewModelHelper = ViewModelHelper()
    var viewModelProtocol: CollectionViewModel?
    var viewRocketParamData = [DataRocket.ParamRocket]()
    var dictionaryRocket: [String: String] = [:]
    var indexPageControl = 0
    var viewModelUsersetting = SettingParamertUserDefaults()
    var arrayParametrName = [String]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstUpdateCollectionView()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func firstUpdateCollectionView() {
        if arrayParametrName.isEmpty {
            viewModelUsersetting.readUserSettingParametr { height, diameter, mass, leo in
                print(height, diameter, mass, leo)
                if height.description.isEmpty || diameter.description.isEmpty || mass.description.isEmpty || leo.description.isEmpty {
                    self.didUpdateRocketParameters(height: 0, diameter: 0, mass: 0, leo: 0)
                }
                self.didUpdateRocketParameters(height: height, diameter: diameter, mass: mass, leo: leo)
            }
        }
    }
    
    func didSelectPage() {
            let tappedPageIndex = self.pageControl.currentPage
            self.indexPageControl = tappedPageIndex
            self.updateCell()
            self.updateUI()
    }
    
    func didUpdateRocketParameters(height: Int, diameter: Int, mass: Int, leo: Int) {
        arrayParametrName.removeAll()
            if let newHeightUnit = HeightUnit(rawValue: height) {
                self.viewModelparametrRocket.currentHeightUnit = newHeightUnit
                if let unit = HeightUnit(rawValue: height) {
                    let description = unit.description(for: height)
                    self.arrayParametrName.append("Высота, \(description)")
                }
            }
            if let newDiameterUnit = DiameterUnit(rawValue: diameter) {
                self.viewModelparametrRocket.currentDiameterUnit = newDiameterUnit
                if let unit = DiameterUnit(rawValue: diameter) {
                    let description = unit.description(for: diameter)
                    self.arrayParametrName.append("Диаметр, \(description)")
                }
            }
            if let newMassUnit = WeightUnit(rawValue: mass) {
                self.viewModelparametrRocket.currentWeightUnit = newMassUnit
                if let unit = WeightUnit(rawValue: mass) {
                    let description = unit.description(for: mass)
                    self.arrayParametrName.append("Масса, \(description)")
                }
            }
            if let newLeoUnit = LeoUnit(rawValue: leo) {
                self.viewModelparametrRocket.currentLeoUnit = newLeoUnit
                if let unit = LeoUnit(rawValue: leo) {
                    let description = unit.description(for: leo)
                    self.arrayParametrName.append("Нагрузка, \(description)")
                }
            }
            self.viewModelparametrRocket.processJSONData()
            self.updateCell()
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
                self.viewModelHelper.loadImage(from: rocket.imageView ?? "rocket", into: self.imageRocket)
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
     

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        pageControl.backgroundColor = .systemFill
        pageControl.addTarget(self, action: #selector(tapPageControl), for: .valueChanged)
        
        return pageControl
    }()
       
      @objc private func tapPageControl() {
          didSelectPage()
      }
       
        private let scrollInfoRocket: UIScrollView = {
           let scrollInfoRocket = UIScrollView()
           scrollInfoRocket.backgroundColor = .white
           return scrollInfoRocket
       }()
       
    private let contentView: UIView = {
           let contentView = UIView()
           return contentView
       }()
       
    private let imageRocket: UIImageView = {
           let imageRocket = UIImageView()
           imageRocket.image = UIImage(named: "rocket")
           return imageRocket
       }()
       
    private let blackView: UIView = {
           let blackView = UIView()
           blackView.backgroundColor = .black
           blackView.layer.cornerRadius = 30
           return blackView
       }()
       
    private lazy var settingButtonIcon: UIButton = {
           let settingButtonIcon = UIButton()
           settingButtonIcon.setImage(UIImage(named: "Setting.png"), for: .normal)
           settingButtonIcon.addTarget(self, action: #selector(viewSettingParamRocket), for: .touchUpInside)
           return settingButtonIcon
       }()
       
       @objc private func viewSettingParamRocket() {
           let settingParamRocket = SettingViewParamRocketController()
           settingParamRocket.delegate = self
               present(settingParamRocket, animated: true)
       }
       
    private let labelName: UILabel = {
           let labelName = UILabel()
           labelName.font = UIFont(name: "Lab Grotesque", size: 24)
           labelName.font = UIFont.systemFont(ofSize: 32, weight: .bold)
           labelName.textColor = .white
           labelName.text = ""
           return labelName
       }()
       
    private let collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           layout.scrollDirection = .horizontal
           cv.showsHorizontalScrollIndicator = false
           cv.backgroundColor = .black
           
           return cv
       }()
       
    private let labelDateOneStart: UILabel = {
           let labelDateOneStart = UILabel()
           labelDateOneStart.font = UIFont(name: "Lab Grotesque", size: 16)
           labelDateOneStart.textColor = .white
           labelDateOneStart.text = "Первый запуск"
           return labelDateOneStart
       }()
       
    private let dateOneStart: UILabel = {
           let dateOneStart = UILabel()
           dateOneStart.font = UIFont(name: "Lab Grotesque", size: 16)
           dateOneStart.textColor = .white
           dateOneStart.textAlignment = .right
           dateOneStart.text = ""
           return dateOneStart
       }()
       
    private let labelCountry: UILabel = {
           let labelCountry = UILabel()
           labelCountry.font = UIFont(name: "Lab Grotesque", size: 16)
           labelCountry.textColor = .white
           labelCountry.text = "Страна"
           return labelCountry
       }()
       
    private let country: UILabel = {
        let country = UILabel()
        country.font = UIFont(name: "Lab Grotesque", size: 16)
        country.textColor = .white
        country.text = ""
        country.textAlignment = .right
        country.numberOfLines = 1
        
        return country
    }()
       
    private let labelStartupCost: UILabel = {
           let labelStartupCost = UILabel()
           labelStartupCost.font = UIFont(name: "Lab Grotesque", size: 16)
           labelStartupCost.textColor = .white
           labelStartupCost.text = "Стоимость запуска"
           return labelStartupCost
       }()
       
    private let startupCost: UILabel = {
           let startupCost = UILabel()
           startupCost.font = UIFont(name: "Lab Grotesque", size: 16)
           startupCost.textColor = .white
           startupCost.text = ""
           startupCost.textAlignment = .right
           return startupCost
       }()
       
    private let labelFirstStep: UILabel = {
           let labelFirstStep = UILabel()
           labelFirstStep.font = UIFont(name: "Lab Grotesque", size: 16)
           labelFirstStep.textColor = .white
           labelFirstStep.font = UIFont.systemFont(ofSize: 24, weight: .bold)
           labelFirstStep.text = "Первая ступень"
           return labelFirstStep
       }()
       
    private let labelFirstStageNumberOfEngines: UILabel = {
           let labelFirstStageNumberOfEngines = UILabel()
           labelFirstStageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
           labelFirstStageNumberOfEngines.textColor = .white
           labelFirstStageNumberOfEngines.text = "Количество двигателей"
           return labelFirstStageNumberOfEngines
       }()
       
    private let firstStageNumberOfEngines: UILabel = {
           let firstStageNumberOfEngines = UILabel()
           firstStageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
           firstStageNumberOfEngines.textColor = .white
           firstStageNumberOfEngines.text = ""
           firstStageNumberOfEngines.textAlignment = .right
           return firstStageNumberOfEngines
       }()
       
    private let labelFirstStageQuantitOfFuelInTons: UILabel = {
           let labelFirstStageQuantitOfFuelInTons = UILabel()
           labelFirstStageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
           labelFirstStageQuantitOfFuelInTons.textColor = .white
           labelFirstStageQuantitOfFuelInTons.text = "Количество топлива"
           return labelFirstStageQuantitOfFuelInTons
       }()
       
    private let firstStageQuantitOfFuelInTons: UILabel = {
           let firstStageQuantitOfFuelInTons = UILabel()
           firstStageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
           firstStageQuantitOfFuelInTons.textColor = .white
           firstStageQuantitOfFuelInTons.text = ""
           firstStageQuantitOfFuelInTons.textAlignment = .right
           return firstStageQuantitOfFuelInTons
       }()
       
    private let labelFirstStageBurnTimeInSeconds: UILabel = {
           let labelFirstStageBurnTimeInSeconds = UILabel()
           labelFirstStageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
           labelFirstStageBurnTimeInSeconds.textColor = .white
           labelFirstStageBurnTimeInSeconds.text = "Время сгорания"
           return labelFirstStageBurnTimeInSeconds
       }()
       
    private let firstStageBurnTimeInSeconds: UILabel = {
           let firstStageBurnTimeInSeconds = UILabel()
           firstStageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
           firstStageBurnTimeInSeconds.textColor = .white
           firstStageBurnTimeInSeconds.text = ""
           firstStageBurnTimeInSeconds.textAlignment = .right
           return firstStageBurnTimeInSeconds
       }()
       
    private let labelSecondStep: UILabel = {
           let labelSecondStep = UILabel()
           labelSecondStep.font = UIFont(name: "Lab Grotesque", size: 16)
           labelSecondStep.textColor = .white
           labelSecondStep.font = UIFont.systemFont(ofSize: 24, weight: .bold)
           labelSecondStep.text = "Вторая ступень"
           return labelSecondStep
       }()
       
    private let labelSecondStageNumberOfEngines: UILabel = {
           let StageNumberOfEngines = UILabel()
           StageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
           StageNumberOfEngines.textColor = .white
           StageNumberOfEngines.text = "Количество двигателей"
           return StageNumberOfEngines
       }()
       
    private let secondStageNumberOfEngines: UILabel = {
           let StageNumberOfEngines = UILabel()
           StageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
           StageNumberOfEngines.textColor = .white
           StageNumberOfEngines.text = ""
           StageNumberOfEngines.textAlignment = .right
           return StageNumberOfEngines
       }()
       
    private let labelSecondStageQuantitOfFuelInTons: UILabel = {
           let StageQuantitOfFuelInTons = UILabel()
           StageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
           StageQuantitOfFuelInTons.textColor = .white
           StageQuantitOfFuelInTons.text = "Количество топлива"
           return StageQuantitOfFuelInTons
       }()
       
    private let secondStageQuantitOfFuelInTons: UILabel = {
           let StageQuantitOfFuelInTons = UILabel()
           StageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
           StageQuantitOfFuelInTons.textColor = .white
           StageQuantitOfFuelInTons.text = ""
           StageQuantitOfFuelInTons.textAlignment = .right
           return StageQuantitOfFuelInTons
       }()
       
    private let labelSecondStageBurnTimeInSeconds: UILabel = {
           let StageBurnTimeInSeconds = UILabel()
           StageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
           StageBurnTimeInSeconds.textColor = .white
           StageBurnTimeInSeconds.text = "Время сгорания"
           return StageBurnTimeInSeconds
       }()
       
    private let secondStageBurnTimeInSeconds: UILabel = {
           let StageBurnTimeInSeconds = UILabel()
           StageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
           StageBurnTimeInSeconds.textColor = .white
           StageBurnTimeInSeconds.text = ""
           StageBurnTimeInSeconds.textAlignment = .right
           return StageBurnTimeInSeconds
       }()
       
    private lazy var buttonToViewLaunches: UIButton = {
           let buttonToViewLaunches = UIButton()
           buttonToViewLaunches.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
           buttonToViewLaunches.setTitle("Посмотреть запуски", for: .normal)
           buttonToViewLaunches.layer.cornerRadius = 20
           buttonToViewLaunches.backgroundColor = .systemGray
           buttonToViewLaunches.tintColor = .white
           buttonToViewLaunches.addTarget(self, action: #selector(viewListSpaceRocket), for: .touchUpInside)
           return buttonToViewLaunches
       }()
       
      @objc private func viewListSpaceRocket() {
           let listSpaceRocket = TableListSpaceRocketController()
          navigationController?.pushViewController(listSpaceRocket, animated: true)
       }
       
       func constraints() {
           scrollInfoRocket.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
           
           contentView.snp.makeConstraints { make in
               make.edges.width.equalTo(scrollInfoRocket)
           }
           
           imageRocket.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(-60)
               make.width.equalToSuperview()
               make.height.equalToSuperview().multipliedBy(0.4)
           }
           
           blackView.snp.makeConstraints { make in
               make.top.equalTo(imageRocket.snp.bottom).inset(145)
               make.left.width.equalToSuperview()
               make.height.equalToSuperview().multipliedBy(0.8)
           }
           
           labelName.snp.makeConstraints { make in
               make.top.equalTo(blackView).offset(48)
               make.left.equalToSuperview().offset(32)
           }
           
           settingButtonIcon.snp.makeConstraints { make in
               make.top.equalTo(blackView).offset(48)
               make.right.equalToSuperview().inset(32)
           }
           
           collectionView.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(112)
               make.left.right.equalToSuperview().offset(0)
               make.height.equalTo(96)
           }

           labelDateOneStart.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(248)
               make.left.equalToSuperview().offset(32)
           }
           
           dateOneStart.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(248)
               make.right.equalToSuperview().inset(32)
               make.left.equalToSuperview().offset(228)
           }
           
           labelCountry.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(288)
               make.left.equalToSuperview().offset(32)
           }
           
           country.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(288)
               make.right.equalToSuperview().inset(32)
               make.left.equalToSuperview().offset(100)
           }
           
           labelStartupCost.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(328)
               make.left.equalToSuperview().offset(32)
           }
           
           startupCost.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(328)
               make.right.equalToSuperview().inset(32)
               make.left.equalToSuperview().offset(233)
           }
           
           labelFirstStep.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(392)
               make.right.left.equalToSuperview().offset(32)
           }
           
           labelFirstStageNumberOfEngines.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(432)
               make.left.equalToSuperview().offset(32)
           }
           
           firstStageNumberOfEngines.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(432)
               make.left.equalToSuperview().offset(277)
               make.right.equalToSuperview().inset(68)
               
           }
           
           labelFirstStageQuantitOfFuelInTons.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(472)
               make.left.equalToSuperview().offset(32)
           }
           
           firstStageQuantitOfFuelInTons.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(472)
               make.right.equalToSuperview().inset(32)
               make.left.equalToSuperview().offset(227)
           }
           
           labelFirstStageBurnTimeInSeconds.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(512)
               make.left.equalToSuperview().offset(32)
           }
           
           firstStageBurnTimeInSeconds.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(512)
               make.right.equalToSuperview().inset(32)
               make.left.equalToSuperview().offset(227)
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
               make.right.equalToSuperview().inset(68)
               make.left.equalToSuperview().offset(227)
           }
           
           labelSecondStageQuantitOfFuelInTons.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(656)
               make.left.equalToSuperview().offset(32)
           }
           
           secondStageQuantitOfFuelInTons.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(656)
               make.right.equalToSuperview().inset(32)
               make.left.equalToSuperview().offset(227)
           }
           
           labelSecondStageBurnTimeInSeconds.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(696)
               make.left.equalToSuperview().offset(32)
           }
           
           secondStageBurnTimeInSeconds.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(696)
               make.right.equalToSuperview().inset(32)
               make.left.equalToSuperview().offset(227)
           }
           
           buttonToViewLaunches.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(749)
               make.right.equalToSuperview().inset(32)
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
