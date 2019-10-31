//
//  DescriptionSuperheroModule.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/31/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import UIKit

class DescriptionSuperheroModule {
    private let presenter: DescriptionSuperheroPresenter
    
    public init(with baseViewController: UIViewController) {
        let wireframe = DescriptionSuperheroWireframe(with: baseViewController)
        
        presenter = DescriptionSuperheroPresenter(wireframe: wireframe)
    }
    
    public func setDataInfo(detailsSuperheroModel: DetailsSuperheroModel) {
        presenter.setDataInfo(detailsSuperheroModel: detailsSuperheroModel)
    }
    
    public func showViewController() {
        presenter.showViewController()
    }
}
