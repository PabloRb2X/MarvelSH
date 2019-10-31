//
//  SelectSuperheroViewController.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/29/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct SuperheroModelSection: SectionModelType {
    var items: [DetailsSuperheroModel]
    typealias Item = DetailsSuperheroModel

    init(items: [DetailsSuperheroModel]) {
        self.items = items
    }
    
    init(original: SuperheroModelSection, items: [DetailsSuperheroModel]) {
        self = original
        self.items = items
    }
}

protocol SelectSuperheroViewOutput {
    var superheroes: Driver<[SuperheroModelSection]> { get }
    func didLoad()
    func presentNextViewController(superheroSelected: DetailsSuperheroModel)
}

class SelectSuperheroViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    
    private let presenter: SelectSuperheroViewOutput
    private lazy var dataSource: RxCollectionViewSectionedReloadDataSource<SuperheroModelSection> = {
        return RxCollectionViewSectionedReloadDataSource<SuperheroModelSection>(
            configureCell: { [weak self] _, collectionView, indexPath, item in
                guard let self = self else { return UICollectionViewCell() }
                
                let superheroCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperheroCell", for: indexPath) as? SelectSuperheroCell
                
                superheroCell?.setup(urlImage: item.photo, nameSuperhero: item.name)
                
                return superheroCell ?? UICollectionViewCell()
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        presenter.didLoad()
    }
    
    init(presenter: SelectSuperheroViewOutput) {
        self.presenter = presenter
        
        super.init(nibName: "SelectSuperheroViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SelectSuperheroViewController {
    func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Superheroes"
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "SelectSuperheroCell", bundle: nil), forCellWithReuseIdentifier: "SuperheroCell")
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        presenter.superheroes
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(DetailsSuperheroModel.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] selectModel in
                print("select model")
                self?.presenter.presentNextViewController(superheroSelected: selectModel)
        }).disposed(by: disposeBag)
    }
}

extension SelectSuperheroViewController: UICollectionViewDelegate { }

extension SelectSuperheroViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: collectionView.bounds.height * 0.12)
    }
}
