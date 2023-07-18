//
//  SettingViewParamRocketController.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 18.07.2023.
//

import UIKit
import SnapKit

class SettingViewParamRocketController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(heightUnit)
        view.addSubview(diameterUnit)
        view.addSubview(weightUnit)
        view.addSubview(leoUnit)
        view.addSubview(heightUnitTougle)


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
    
    private let closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.tintColor = .white
        closeButton.titleLabel?.font = UIFont(name: "Lab Grotesque", size: 16.0)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return closeButton
    }()


    @objc func closeButtonTapped() {
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
    
    private let heightUnitTougle: UISwitch = {
        let heightUnitTougle = UISwitch()
        heightUnitTougle.onTintColor = .white
        heightUnitTougle.thumbTintColor = .gray
        heightUnitTougle.isOn = true
        heightUnitTougle.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return heightUnitTougle
    }()
    
    @objc private func switchValueChanged(sender: UISwitch) {
        if !sender.isOn {
            sender.isOn = true
        }
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
        
        heightUnitTougle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.right.equalToSuperview().offset(-28)
        }
        
    }

}
