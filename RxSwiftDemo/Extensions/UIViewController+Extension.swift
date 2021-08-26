//
//  UIViewController+Extension.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension Reactive where Base: UIViewController {
    
    var error: Binder<APIError> {
        return Binder(base) { vc, error in
            vc.showAlert(title: "Error", message: error.message())
        }
    }
    
    var loading: Binder<Bool> {
        return Binder(base) { vc, isLoading in
            if isLoading {
                MBProgressHUD.showAdded(to: vc.view, animated: true)
            } else {
                MBProgressHUD.hide(for: vc.view, animated: true)
            }
            print("isLoading: \(isLoading)")
        }
    }
}

