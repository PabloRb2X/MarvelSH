//
//  DescriptionSuperheroWireframe.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/31/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import UIKit

class DescriptionSuperheroWireframe {
    private let baseViewController: UIViewController
    
    init(with baseViewController: UIViewController) {
        self.baseViewController = baseViewController
    }
    
    func showViewController(presenter: DescriptionSuperheroPresenter) {
        let descriptionSuperheroViewController = DescriptionSuperheroViewController(presenter: presenter)
        
        guard let base = baseViewController as? UINavigationController else {
            return
        }
        
        base.pushViewController(descriptionSuperheroViewController, animated: true)
    }
}
