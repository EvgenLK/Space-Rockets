import UIKit
import SnapKit

class ViewController: UIViewController {
    
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




        blackView.addSubview(collectionView)
        
        constraints()
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
    
    private let imageRocket: UIImageView = {
        let imageRocket = UIImageView()
        imageRocket.translatesAutoresizingMaskIntoConstraints = false
        imageRocket.image = UIImage(named: "rocket")
        return imageRocket
    }()
    
    private let settingButtonIcon: UIButton = {
        let settingIcon = UIButton()
        settingIcon.translatesAutoresizingMaskIntoConstraints = false
        settingIcon.setImage(UIImage(named: "Setting"), for: .normal)
        return settingIcon
    }()
    
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
        labelName.text = "Falcon Heavy"
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
        dateOneStart.text = "7 февраля 2023"
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
        country.text = "США"
        country.textAlignment = .center
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
        startupCost.text = "$98 млн."
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
        firstStageNumberOfEngines.text = "28"
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
        firstStageQuantitOfFuelInTons.text = "284 №%: "
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
        firstStageBurnTimeInSeconds.text = "594 sec"
        firstStageBurnTimeInSeconds.textAlignment = .center
        return firstStageBurnTimeInSeconds
    }()
    

    
    func constraints() {
        scrollInfoRocket.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollInfoRocket)
            make.width.equalTo(scrollInfoRocket)
        }
        
        imageRocket.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-60)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        blackView.snp.makeConstraints { make in
            make.top.equalTo(imageRocket.snp.bottom).offset(-200)
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
            make.left.equalToSuperview().offset(233)
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
    }
}
