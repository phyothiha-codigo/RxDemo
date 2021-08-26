//
//  NSObject.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 11/08/2021.
//

import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
