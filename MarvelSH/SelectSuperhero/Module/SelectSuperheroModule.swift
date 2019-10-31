//
//  SelectSuperheroModule.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/29/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import UIKit

class SelectSuperheroModule {
    private let presenter: SelectSuperheroPresenter
    
    public init(with baseViewController: UIViewController) {
        let interactor = SelectSuperheroInteractor()
        let wireframe = SelectSuperheroWireframe(with: baseViewController)
        
        presenter = SelectSuperheroPresenter(interactor: interactor, wireframe: wireframe)
    }
    
    public func showViewController() {
        presenter.showViewController()
    }
}
