//
//  SelectSuperheroWireframe.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/29/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import UIKit

protocol SelectSuperheroWireframeProtocol {
    func presentNextViewController(superheroSelected: DetailsSuperheroModel)
}

class SelectSuperheroWireframe {
    private let baseViewController: UIViewController
    
    init(with baseViewController: UIViewController) {
        self.baseViewController = baseViewController
    }
    
    func showViewController(presenter: SelectSuperheroPresenter) {
        let selectSuperheroViewController = SelectSuperheroViewController(presenter: presenter)
        
        guard let base = baseViewController as? UINavigationController else {
            return
        }
        
        base.pushViewController(selectSuperheroViewController, animated: true)
    }
}

extension SelectSuperheroWireframe: SelectSuperheroWireframeProtocol {
    func presentNextViewController(superheroSelected: DetailsSuperheroModel) {
        let descriptionSuperheroModule = DescriptionSuperheroModule(with: baseViewController)
        
        descriptionSuperheroModule.setDataInfo(detailsSuperheroModel: superheroSelected)
        descriptionSuperheroModule.showViewController()
    }
}
