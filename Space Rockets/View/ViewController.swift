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

        blackView.addSubview(collectionView)
        
        constraints()
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
    
    let imageRocket: UIImageView = {
        let imageRocket = UIImageView()
        imageRocket.translatesAutoresizingMaskIntoConstraints = false
        imageRocket.image = UIImage(named: "rocket")
        return imageRocket
    }()
    
    let settingButtonIcon: UIButton = {
        let settingIcon = UIButton()
        settingIcon.translatesAutoresizingMaskIntoConstraints = false
        settingIcon.setImage(UIImage(named: "Setting"), for: .normal)
        return settingIcon
    }()
    
    let blackView: UIView = {
        let blackView = UIView()
        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.backgroundColor = .black
        blackView.layer.cornerRadius = 30
        return blackView
    }()
    
    let labelName: UILabel = {
        let labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.font = UIFont(name: "Lab Grotesque", size: 24)
        labelName.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        labelName.textColor = .white
        labelName.text = "Falcon Heavy"
        return labelName
    }()
    
    let collectionView: UICollectionView = {
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
        dateOneStart.text = "7 февраля 2023"
        return dateOneStart
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
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        blackView.snp.makeConstraints { make in
            make.top.equalTo(imageRocket.snp.bottom).offset(-100)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
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
        
    }
}
