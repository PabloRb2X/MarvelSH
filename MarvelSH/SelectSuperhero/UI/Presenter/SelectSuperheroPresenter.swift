//
//  SelectSuperheroPresenter.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/29/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SelectSuperheroPresenter {
    private let interactor: SelectSuperheroInteractor
    private let wireframe: SelectSuperheroWireframe
    
    private var superheroesSubject = BehaviorRelay<[SuperheroModelSection]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    init(interactor: SelectSuperheroInteractor, wireframe: SelectSuperheroWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func showViewController() {
        wireframe.showViewController(presenter: self)
    }
}

extension SelectSuperheroPresenter: SelectSuperheroViewOutput {
    func presentNextViewController(superheroSelected: DetailsSuperheroModel) {
        wireframe.presentNextViewController(superheroSelected: superheroSelected)
    }
    
    var superheroes: Driver<[SuperheroModelSection]> {
        return superheroesSubject.asDriver(onErrorJustReturn: [])
    }
    
    func didLoad() {
        interactor.requestSuperheroes().subscribe(onNext: { [weak self] superheroModel in
            guard let self = self else { return }
            
            print(superheroModel)
            self.superheroesSubject.accept(self.getSuperheroModel(superheroModel: superheroModel))
            
        }, onError: { error in
            print("Error")
        }).disposed(by: disposeBag)
    }
    
    private func getSuperheroModel(superheroModel: SuperheroModel) -> [SuperheroModelSection] {
        var superheroModelSection: [SuperheroModelSection] = []
        
        superheroModelSection.append(SuperheroModelSection(items: superheroModel.superheroes))
        
        return superheroModelSection
    }
}
