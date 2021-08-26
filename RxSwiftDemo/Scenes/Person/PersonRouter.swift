//
//  PersonRouter.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 16/08/2021.
//

import UIKit

protocol PersonRoutingLogic: RoutingLogic {
}

class PersonRouter: PersonRoutingLogic {
    var vc: UIViewController?
}
