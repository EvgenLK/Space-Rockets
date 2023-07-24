import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    let viewmodelresponse = ResponseDataRocket()
    private let viewModel = ViewModelResponseRocket()
    let viewModelDF = ViewModelHelper()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollInfoRocket)
        scrollInfoRocket.addSubview(contentView)
        contentView.addSubview(imageRocket)
        contentView.addSubview(blackView)
        blackView.addSubview(settingButtonIcon)
        blackView.addSubview(labelName)
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
        blackView.addSubview(collectionView)
        constraints()
        
        
        viewmodelresponse.getRockets { json in
            self.viewModel.processJSONData(json as! [SpaceDatumRocket])
            self.updateUI()
        }
        
    }
    func updateUI() {

        let rocketInfo = viewModel.getRocketDataInfo()
//        let rocketParam = viewModel.getRocketDataParam()
        let rocketData = viewModel.getRocketDataData()

//        let numberOfRockets = viewModel.getNumberOfRockets()
        DispatchQueue.main.async {
            if let rocket = rocketInfo.first {
                self.dateOneStart.text = self.viewModelDF.formatDate(dateString: rocket.dateOneStart)
                self.country.text = rocket.country
                self.startupCost.text = rocket.startupCost
                self.firstStageNumberOfEngines.text = rocket.firstStageNumberOfEngines
                self.firstStageBurnTimeInSeconds.text = rocket.firstStageBurnTimeInSeconds
                self.firstStageQuantitOfFuelInTons.text = rocket.firstStageQuantitOfFuelInTons
                self.secondStageNumberOfEngines.text = rocket.secondStageNumberOfEngines
                self.secondStageBurnTimeInSeconds.text = rocket.secondStageBurnTimeInSeconds
                self.secondStageQuantitOfFuelInTons.text = rocket.secondStageQuantitOfFuelInTons
            }
            
            if let rocket = rocketData.first {
                self.labelName.text = rocket.name                
            }
        }
    }

//    var viewModelInfoRoc: ViewModelInfoRocket? {
//        didSet{
//            guard let viewModelInfoRoc = viewModelInfoRoc else { return }
//            dateOneStart.text = viewModelInfoRoc.dateOneStart
//            country.text = viewModelInfoRoc.country
//            startupCost.text = viewModelInfoRoc.startupCost
//            firstStageNumberOfEngines.text = viewModelInfoRoc.firstStageNumberOfEngines
//            firstStageBurnTimeInSeconds.text = viewModelInfoRoc.firstStageBurnTimeInSeconds
//            firstStageQuantitOfFuelInTons.text = viewModelInfoRoc.firstStageQuantitOfFuelInTons
//            secondStageNumberOfEngines.text = viewModelInfoRoc.secondStageNumberOfEngines
//            secondStageBurnTimeInSeconds.text = viewModelInfoRoc.secondStageBurnTimeInSeconds
//            secondStageQuantitOfFuelInTons.text = viewModelInfoRoc.secondStageQuantitOfFuelInTons
//        }
//    }

    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        pageControl.backgroundColor = .systemFill
        pageControl.addTarget(self, action: #selector(tapPageControl), for: .touchUpInside)
        return pageControl
    }()
    
   @objc func tapPageControl() {

    }
    
    private let scrollInfoRocket: UIScrollView = {
        let scrollInfoRocket = UIScrollView()
        scrollInfoRocket.translatesAutoresizingMaskIntoConstraints = false
        scrollInfoRocket.backgroundColor = .white
        return scrollInfoRocket
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private var imageRocket: UIImageView = {
        let imageRocket = UIImageView()
        imageRocket.translatesAutoresizingMaskIntoConstraints = false
        imageRocket.image = UIImage(named: "rocket")
        return imageRocket
    }()
    
    private let settingButtonIcon: UIButton = {
        let settingIcon = UIButton()
        settingIcon.translatesAutoresizingMaskIntoConstraints = false
        settingIcon.setImage(UIImage(named: "Setting"), for: .normal)
        settingIcon.addTarget(self, action: #selector(viewSettingParamRocket), for: .touchUpInside)
        return settingIcon
    }()
    
    @objc func viewSettingParamRocket() {
        let settingParamRocket = SettingViewParamRocketController()
        present(settingParamRocket, animated: true)
    }
    
    private let blackView: UIView = {
        let blackView = UIView()
        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.backgroundColor = .black
        blackView.layer.cornerRadius = 30
        return blackView
    }()
    
    private let labelName: UILabel = {
        let labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
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
        cv.layer.opacity = 0.6
        cv.layer.cornerRadius = 20
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        return cv
    }()
    
    private let labelDateOneStart: UILabel = {
        let labelDateOneStart = UILabel()
        labelDateOneStart.translatesAutoresizingMaskIntoConstraints = false
        labelDateOneStart.font = UIFont(name: "Lab Grotesque", size: 16)
        labelDateOneStart.textColor = .white
        labelDateOneStart.text = "Первый запуск"
        return labelDateOneStart
    }()
    
    private let dateOneStart: UILabel = {
        let dateOneStart = UILabel()
        dateOneStart.translatesAutoresizingMaskIntoConstraints = false
        dateOneStart.font = UIFont(name: "Lab Grotesque", size: 16)
        dateOneStart.textColor = .white
        dateOneStart.textAlignment = .center
        dateOneStart.text = ""
        return dateOneStart
    }()
    
    private let labelCountry: UILabel = {
        let labelCountry = UILabel()
        labelCountry.translatesAutoresizingMaskIntoConstraints = false
        labelCountry.font = UIFont(name: "Lab Grotesque", size: 16)
        labelCountry.textColor = .white
        labelCountry.text = "Страна"
        return labelCountry
    }()
    
    private let country: UILabel = {
        let country = UILabel()
        country.translatesAutoresizingMaskIntoConstraints = false
        country.font = UIFont(name: "Lab Grotesque", size: 16)
        country.textColor = .white
        country.text = ""
        country.textAlignment = .right
        
        return country
    }()
    
    private let labelStartupCost: UILabel = {
        let labelStartupCost = UILabel()
        labelStartupCost.translatesAutoresizingMaskIntoConstraints = false
        labelStartupCost.font = UIFont(name: "Lab Grotesque", size: 16)
        labelStartupCost.textColor = .white
        labelStartupCost.text = "Стоимость запуска"
        return labelStartupCost
    }()
    
    private let startupCost: UILabel = {
        let startupCost = UILabel()
        startupCost.translatesAutoresizingMaskIntoConstraints = false
        startupCost.font = UIFont(name: "Lab Grotesque", size: 16)
        startupCost.textColor = .white
        startupCost.text = ""
        startupCost.textAlignment = .center
        return startupCost
    }()
    
    private let labelFirstStep: UILabel = {
        let labelFirstStep = UILabel()
        labelFirstStep.translatesAutoresizingMaskIntoConstraints = false
        labelFirstStep.font = UIFont(name: "Lab Grotesque", size: 16)
        labelFirstStep.textColor = .white
        labelFirstStep.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        labelFirstStep.text = "Первая ступень"
        return labelFirstStep
    }()
    
    private let labelFirstStageNumberOfEngines: UILabel = {
        let labelFirstStageNumberOfEngines = UILabel()
        labelFirstStageNumberOfEngines.translatesAutoresizingMaskIntoConstraints = false
        labelFirstStageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
        labelFirstStageNumberOfEngines.textColor = .white
        labelFirstStageNumberOfEngines.text = "Количесво двигателей"
        return labelFirstStageNumberOfEngines
    }()
    
    private let firstStageNumberOfEngines: UILabel = {
        let firstStageNumberOfEngines = UILabel()
        firstStageNumberOfEngines.translatesAutoresizingMaskIntoConstraints = false
        firstStageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
        firstStageNumberOfEngines.textColor = .white
        firstStageNumberOfEngines.text = ""
        firstStageNumberOfEngines.textAlignment = .center
        return firstStageNumberOfEngines
    }()
    
    private let labelFirstStageQuantitOfFuelInTons: UILabel = {
        let labelFirstStageQuantitOfFuelInTons = UILabel()
        labelFirstStageQuantitOfFuelInTons.translatesAutoresizingMaskIntoConstraints = false
        labelFirstStageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
        labelFirstStageQuantitOfFuelInTons.textColor = .white
        labelFirstStageQuantitOfFuelInTons.text = "Количесво топлива"
        return labelFirstStageQuantitOfFuelInTons
    }()
    
    private let firstStageQuantitOfFuelInTons: UILabel = {
        let firstStageQuantitOfFuelInTons = UILabel()
        firstStageQuantitOfFuelInTons.translatesAutoresizingMaskIntoConstraints = false
        firstStageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
        firstStageQuantitOfFuelInTons.textColor = .white
        firstStageQuantitOfFuelInTons.text = ""
        firstStageQuantitOfFuelInTons.textAlignment = .center
        return firstStageQuantitOfFuelInTons
    }()
    
    private let labelFirstStageBurnTimeInSeconds: UILabel = {
        let labelFirstStageBurnTimeInSeconds = UILabel()
        labelFirstStageBurnTimeInSeconds.translatesAutoresizingMaskIntoConstraints = false
        labelFirstStageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
        labelFirstStageBurnTimeInSeconds.textColor = .white
        labelFirstStageBurnTimeInSeconds.text = "Время сгорания"
        return labelFirstStageBurnTimeInSeconds
    }()
    
    private let firstStageBurnTimeInSeconds: UILabel = {
        let firstStageBurnTimeInSeconds = UILabel()
        firstStageBurnTimeInSeconds.translatesAutoresizingMaskIntoConstraints = false
        firstStageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
        firstStageBurnTimeInSeconds.textColor = .white
        firstStageBurnTimeInSeconds.text = ""
        firstStageBurnTimeInSeconds.textAlignment = .center
        return firstStageBurnTimeInSeconds
    }()
    
    private let labelSecondStep: UILabel = {
        let labelSecondStep = UILabel()
        labelSecondStep.translatesAutoresizingMaskIntoConstraints = false
        labelSecondStep.font = UIFont(name: "Lab Grotesque", size: 16)
        labelSecondStep.textColor = .white
        labelSecondStep.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        labelSecondStep.text = "Вторая ступень"
        return labelSecondStep
    }()
    
    private let labelSecondStageNumberOfEngines: UILabel = {
        let StageNumberOfEngines = UILabel()
        StageNumberOfEngines.translatesAutoresizingMaskIntoConstraints = false
        StageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
        StageNumberOfEngines.textColor = .white
        StageNumberOfEngines.text = "Количесво двигателей"
        return StageNumberOfEngines
    }()
    
    private let secondStageNumberOfEngines: UILabel = {
        let StageNumberOfEngines = UILabel()
        StageNumberOfEngines.translatesAutoresizingMaskIntoConstraints = false
        StageNumberOfEngines.font = UIFont(name: "Lab Grotesque", size: 16)
        StageNumberOfEngines.textColor = .white
        StageNumberOfEngines.text = ""
        StageNumberOfEngines.textAlignment = .center
        return StageNumberOfEngines
    }()
    
    private let labelSecondStageQuantitOfFuelInTons: UILabel = {
        let StageQuantitOfFuelInTons = UILabel()
        StageQuantitOfFuelInTons.translatesAutoresizingMaskIntoConstraints = false
        StageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
        StageQuantitOfFuelInTons.textColor = .white
        StageQuantitOfFuelInTons.text = "Количесво топлива"
        return StageQuantitOfFuelInTons
    }()
    
    private let secondStageQuantitOfFuelInTons: UILabel = {
        let StageQuantitOfFuelInTons = UILabel()
        StageQuantitOfFuelInTons.translatesAutoresizingMaskIntoConstraints = false
        StageQuantitOfFuelInTons.font = UIFont(name: "Lab Grotesque", size: 16)
        StageQuantitOfFuelInTons.textColor = .white
        StageQuantitOfFuelInTons.text = ""
        StageQuantitOfFuelInTons.textAlignment = .center
        return StageQuantitOfFuelInTons
    }()
    
    private let labelSecondStageBurnTimeInSeconds: UILabel = {
        let StageBurnTimeInSeconds = UILabel()
        StageBurnTimeInSeconds.translatesAutoresizingMaskIntoConstraints = false
        StageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
        StageBurnTimeInSeconds.textColor = .white
        StageBurnTimeInSeconds.text = "Время сгорания"
        return StageBurnTimeInSeconds
    }()
    
    private let secondStageBurnTimeInSeconds: UILabel = {
        let StageBurnTimeInSeconds = UILabel()
        StageBurnTimeInSeconds.translatesAutoresizingMaskIntoConstraints = false
        StageBurnTimeInSeconds.font = UIFont(name: "Lab Grotesque", size: 16)
        StageBurnTimeInSeconds.textColor = .white
        StageBurnTimeInSeconds.text = ""
        StageBurnTimeInSeconds.textAlignment = .center
        return StageBurnTimeInSeconds
    }()
    
    private let buttonToViewLaunches: UIButton = {
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
