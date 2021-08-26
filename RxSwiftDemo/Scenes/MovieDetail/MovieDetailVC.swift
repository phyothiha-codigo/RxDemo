//
//  MovieDetailVC.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 13/08/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import Cosmos

class MovieDetailVC: UIViewController, AppStoryboard {

    static var storyboard: Storyboard = .main
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var ratingBar: CosmosView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    
    var movieId: Int = 0
    
    private var vm: MovieDetailVM?
    private var router: MovieDetailRouter?
    private let bag = DisposeBag()
    
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
        vm = MovieDetailVM()
        router = MovieDetailRouter()
        router?.vc = self
    }
    
    func setupView() {
        btnPlay.layer.cornerRadius = 4
        btnDownload.layer.cornerRadius = 4
        
        btnClose.rx.tap
            .bind(onNext: { [weak self] in
                self?.router?.routeBack()
            })
            .disposed(by: bag)
    }
    
    func setupBindings() {
        guard let vm = vm else {
            print("❗️VM object is nil!")
            return
        }
        
        let input = MovieDetailVM.Input(movieId: Observable.just(movieId))
        
        let dependencies = MovieDetailVM.Dependencies(service: .shared)
        let output = vm.create(input: input, dependencies: dependencies)
        
        output.detail
            .drive(rx.bindMovieDetail)
            .disposed(by: bag)
                
        output.loading
            .drive(rx.loading)
            .disposed(by: bag)
        
        output.error
            .drive(rx.error)
            .disposed(by: bag)
    }
}

extension Reactive where Base: MovieDetailVC {
    var bindMovieDetail: Binder<MovieDetail> {
        return Binder(base) { vc, movie in
            if let average = movie.rating?.average {
                vc.ratingBar.rating = average / 10 * 5
            }
            vc.imgMovie.setImage(url: movie.image?.medium)
            vc.lblMovieTitle.text = movie.name
            vc.lblType.text = "Genre: \(movie.getGenres())"
            vc.lblDuration.text = "\(movie.averageRuntime ?? 0) minutes"
            vc.lblDescription.text = movie.summary?.htmlString
        }
    }
}
