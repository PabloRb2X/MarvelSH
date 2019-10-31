//
//  DescriptionSuperheroPresenter.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/31/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DescriptionSuperheroPresenter {
    private let wireframe: DescriptionSuperheroWireframe
    
    private var detailsSuperheroModel: DetailsSuperheroModel?
    private var groupsDS = BehaviorRelay<[String]>(value: [])
    
    init(wireframe: DescriptionSuperheroWireframe) {
        self.wireframe = wireframe
    }
    
    func setDataInfo(detailsSuperheroModel: DetailsSuperheroModel) {
        self.detailsSuperheroModel = detailsSuperheroModel
    }
    
    func showViewController() {
        wireframe.showViewController(presenter: self)
    }
}

extension DescriptionSuperheroPresenter: DescriptionSuperheroViewOutput {
    var groupsDataSource: BehaviorRelay<[String]> {
        return groupsDS
    }
    
    var title: String {
        return detailsSuperheroModel?.name ?? ""
    }
    
    var realName: String {
        return detailsSuperheroModel?.realName ?? ""
    }
    
    var height: String {
        return detailsSuperheroModel?.height ?? ""
    }
    
    var power: String {
        return detailsSuperheroModel?.power ?? ""
    }
    
    var abilities: String {
        return detailsSuperheroModel?.abilities ?? ""
    }
    
    var groups: String {
        return detailsSuperheroModel?.groups ?? ""
    }
    
    var photo: String {
        return detailsSuperheroModel?.photo ?? ""
    }
    
    func didLoad() {
        createGroups()
    }
    
    private func createGroups() {
        if let groupsDetails = detailsSuperheroModel?.groups {
            let formedGroups = groupsDetails.components(separatedBy: ",")
            
            groupsDS.accept(formedGroups)
        }
    }
}
