//
//  MovieRouter.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import UIKit

protocol RoutingLogic {
    var vc: UIViewController? { get set }
    func routeBack()
}

extension RoutingLogic {
    func routeBack() {
        vc?.dismiss(animated: true, completion: nil)
    }
}

protocol MovieRoutingLogic: RoutingLogic {
    func routeToDetail(id: Int)
    func routeToPersons()
}

class MovieRouter: MovieRoutingLogic {
    var vc: UIViewController?
    func routeToDetail(id: Int) {
        let detailVC = MovieDetailVC.screen()
        detailVC.movieId = id
        vc?.present(detailVC, animated: true)
    }
    
    func routeToPersons() {
        let personVC = PersonVC.screen()
        vc?.navigationController?.pushViewController(personVC, animated: true)
    }
}
