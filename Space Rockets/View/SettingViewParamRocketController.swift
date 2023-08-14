//
//  SettingViewParamRocketController.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 18.07.2023.
//
import Foundation
import UIKit
import SnapKit

final class SettingViewParamRocketController: UIViewController {
    
    weak var delegate: SettingViewParamRocketDelegate?
    
    var tappedValueHeight: Int = 0
    var tappedValueDiameter: Int = 0
    var tappedValueMass: Int = 0
    var tappedValueLeo: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        constraintsElements()
    }
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Настройки"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Lab Grotesque", size: 16)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.tintColor = .white
        closeButton.titleLabel?.font = UIFont(name: "Lab Grotesque", size: 16.0)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return closeButton
    }()

    @objc private func closeButtonTapped() {
        delegate?.didUpdateRocketParameters(height: tappedValueHeight, diameter: tappedValueDiameter, mass: tappedValueMass, leo: tappedValueLeo)
        dismiss(animated: true, completion: nil)
    }

    private let heightUnit: UILabel = {
        let heightUnit = UILabel()
        heightUnit.text = "Высота"
        heightUnit.textAlignment = .center
        heightUnit.font = UIFont(name: "Lab Grotesque", size: 16.0)
        heightUnit.textColor = .white
        return heightUnit
    }()
    
    private let diameterUnit: UILabel = {
        let diameterUnit = UILabel()
        diameterUnit.text = "Диаметр"
        diameterUnit.textAlignment = .center
        diameterUnit.font = UIFont(name: "Lab Grotesque", size: 16.0)
        diameterUnit.textColor = .white
        return diameterUnit
    }()
    
    private let weightUnit: UILabel = {
        let weightUnit = UILabel()
        weightUnit.text = "Масса"
        weightUnit.textAlignment = .center
        weightUnit.font = UIFont(name: "Lab Grotesque", size: 16.0)
        weightUnit.textColor = .white
        return weightUnit
    }()
    
    private let leoUnit: UILabel = {
        let leoUnit = UILabel()
        leoUnit.text = "Полезная назругка"
        leoUnit.textAlignment = .center
        leoUnit.font = UIFont(name: "Lab Grotesque", size: 16.0)
        leoUnit.textColor = .white
        return leoUnit
    }()
    
    private lazy var heightUnitSegmented: UISegmentedControl = {
        let heightUnitSegmented = UISegmentedControl(items: ["m","ft"])
        heightUnitSegmented.backgroundColor = .darkGray
        heightUnitSegmented.selectedSegmentIndex = tappedValueHeight
        heightUnitSegmented.addTarget(self, action: #selector(setupHeightValue), for: .valueChanged)
        return heightUnitSegmented
    }()
    
    @objc private func setupHeightValue() {
        tappedValueHeight = heightUnitSegmented.selectedSegmentIndex
    }
    
    private lazy var diameterUnitSegmented: UISegmentedControl = {
        let diameterUnitSegmented = UISegmentedControl(items: ["m","ft"])
        diameterUnitSegmented.backgroundColor = .darkGray
        diameterUnitSegmented.selectedSegmentIndex = tappedValueDiameter
        diameterUnitSegmented.addTarget(self, action: #selector(setupDiameterValue), for: .valueChanged)
        return diameterUnitSegmented
    }()
    
    @objc private func setupDiameterValue() {
        tappedValueDiameter = diameterUnitSegmented.selectedSegmentIndex
    }
    
    private lazy var weightUnitSegmented: UISegmentedControl = {
        let weightUnitSegmented = UISegmentedControl(items: ["kg","lb"])
        weightUnitSegmented.backgroundColor = .darkGray
        weightUnitSegmented.selectedSegmentIndex = tappedValueMass
        weightUnitSegmented.addTarget(self, action: #selector(setupMassValue), for: .valueChanged)
        return weightUnitSegmented
    }()
    
    @objc func setupMassValue() {
        tappedValueMass = weightUnitSegmented.selectedSegmentIndex
    }

    private lazy var leoUnitSegmented: UISegmentedControl = {
        let leoUnitSegmented = UISegmentedControl(items: ["kg","lb"])
        leoUnitSegmented.backgroundColor = .darkGray
        leoUnitSegmented.selectedSegmentIndex = tappedValueLeo
        leoUnitSegmented.addTarget(self, action: #selector(setupLeoValue), for: .valueChanged)
        return leoUnitSegmented
    }()
    
    @objc private func setupLeoValue() {
        tappedValueLeo = leoUnitSegmented.selectedSegmentIndex
    }

    func setupView() {
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(heightUnit)
        view.addSubview(diameterUnit)
        view.addSubview(weightUnit)
        view.addSubview(leoUnit)
        view.addSubview(heightUnitSegmented)
        view.addSubview(diameterUnitSegmented)
        view.addSubview(weightUnitSegmented)
        view.addSubview(leoUnitSegmented)
    }
    
    func constraintsElements() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(284)
        }
        
        heightUnit.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(28)
        }
        
        diameterUnit.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(184)
            make.left.equalToSuperview().offset(28)
        }
        
        weightUnit.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240)
            make.left.equalToSuperview().offset(28)
        }
        
        leoUnit.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(304)
            make.left.equalToSuperview().offset(28)
        }
        
        heightUnitSegmented.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.right.equalToSuperview().inset(28)
            make.width.equalTo(115)
            make.height.equalTo(40)
        }
        
        diameterUnitSegmented.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(184)
            make.right.equalToSuperview().inset(28)
            make.width.equalTo(115)
            make.height.equalTo(40)
        }
        
        weightUnitSegmented.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240)
            make.right.equalToSuperview().inset(28)
            make.width.equalTo(115)
            make.height.equalTo(40)
        }
        
        leoUnitSegmented.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(304)
            make.right.equalToSuperview().inset(28)
            make.width.equalTo(115)
            make.height.equalTo(40)
        }
    }
}
