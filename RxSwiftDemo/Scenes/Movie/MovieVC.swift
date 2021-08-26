//
//  MovieVC.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class MovieVC: UIViewController, AppStoryboard {
    
    static var storyboard: Storyboard = .main
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var colMovie: UICollectionView!
    
    private let bag = DisposeBag()
    private var vm: MovieVM?
    private var router: MovieRouter?
    
    private var searchTextEvent: PublishSubject<String> = .init()
    private var cellIdentifier: String = "MovieCell"
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    func setup() {
        vm = MovieVM()
        router = MovieRouter()
        router?.vc = self
    }
    
    func setupView() {
        searchBar.rx.text
            .compactMap({ $0 })
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .asObservable()
            .bind(to: searchTextEvent)
            .disposed(by: bag)
        
        searchBar.showsSearchResultsButton = false
        
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
            })
            .disposed(by: bag)

        colMovie.delegate = self
        colMovie.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        colMovie.contentInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        colMovie.keyboardDismissMode = .interactive
        if let layout = colMovie.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        
        colMovie.rx.modelSelected(Movie.self)
            .map({ $0.id })
            .bind(onNext: { [weak self] id in
                self?.router?.routeToDetail(id: id)
            })
            .disposed(by: bag)
    }
    
    func setupBindings() {
        guard let vm = vm else {
            print("❗️VM object is nil!")
            return
        }
        
        let input = MovieVM.Input(search: searchTextEvent
                                    .startWith("")
                                    .distinctUntilChanged()
                                    .asObservable())
        let dependencies = MovieVM.Dependencies(service: .shared)
        let output = vm.create(input: input, dependencies: dependencies)
        
        output.movies
            .drive( colMovie.rx.items(cellIdentifier: cellIdentifier, cellType: MovieCell.self), curriedArgument: { index, movie, cell in
                cell.movie = movie
            } )
            .disposed(by: bag)
        
        output.movies
            .drive(onNext: { movies in
                print("movies: \(movies.count)")
        }).disposed(by: bag)
        
        output.loading
            .drive(rx.loading)
            .disposed(by: bag)
        
        output.error
            .drive(rx.error)
            .disposed(by: bag)
    }
    
    @IBAction func goToPersons(_ sender: Any) {
        router?.routeToPersons()
    }
}

extension MovieVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 48) / 3
        return .init(width: width, height: width * 1.7)
    }
}

extension Reactive where Base: MovieVC {
    var reloadData: Binder<Void> {
        return Binder(base) { vc, _ in
            vc.colMovie.reloadData()
        }
    }
}
