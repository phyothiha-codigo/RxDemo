//
//  AppStoryboard.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 11/08/2021.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

protocol AppStoryboard: NSObject {
    static var storyboard: Storyboard { get set }
    static func screen() -> Self
}

extension AppStoryboard  {
    static func screen() -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }
}

