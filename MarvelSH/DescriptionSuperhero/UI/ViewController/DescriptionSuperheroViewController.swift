//
//  DescriptionSuperheroViewController.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/31/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DescriptionSuperheroViewOutput {
    var title: String { get }
    var realName: String { get }
    var height: String { get }
    var power: String { get }
    var abilities: String { get }
    var groups: String { get }
    var photo: String { get }
    var groupsDataSource: BehaviorRelay<[String]> { get }
    func didLoad()
}

class DescriptionSuperheroViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = presenter.title
        }
    }
    @IBOutlet private weak var superheroImageView: UIImageView! {
           didSet {
            superheroImageView.imageFromServerURL(presenter.photo, placeHolder: superheroImageView.image)
           }
       }
    @IBOutlet private weak var realNameLabel: UILabel! {
           didSet {
               realNameLabel.text = presenter.realName
           }
       }
    @IBOutlet private weak var heightLabel: UILabel! {
           didSet {
               heightLabel.text = presenter.height
           }
       }
    @IBOutlet private weak var powerLabel: UILabel! {
           didSet {
               powerLabel.text = presenter.power
           }
       }
    @IBOutlet private weak var abilitiesLabel: UILabel! {
           didSet {
               abilitiesLabel.text = presenter.abilities
           }
       }
    
    private let presenter: DescriptionSuperheroViewOutput
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter.didLoad()
    }

    init(presenter: DescriptionSuperheroViewOutput) {
        self.presenter = presenter
        
        super.init(nibName: "DescriptionSuperheroViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DescriptionSuperheroViewController {
    func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        presenter.groupsDataSource.asObservable().bind(to: tableView.rx.items(cellIdentifier: "TableViewCell")) { index, group, cell in
            cell.textLabel?.text = group
        }.disposed(by: disposeBag)
    }
}
