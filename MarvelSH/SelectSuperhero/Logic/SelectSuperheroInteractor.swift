//
//  SelectSuperheroInteractor.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/29/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import RxSwift

protocol SelectSuperheroInteractorProtocol {
    func requestSuperheroes() -> Observable<SuperheroModel>
}

class SelectSuperheroInteractor {
    private let dataManager = APIClient()
    
    init() { }
}

extension SelectSuperheroInteractor: SelectSuperheroInteractorProtocol {
    func requestSuperheroes() -> Observable<SuperheroModel> {
        return dataManager.send(apiRequest: SuperheroesRequest())
    }
}
