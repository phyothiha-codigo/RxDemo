//
//  UIIMageView+Extension.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String?) {
        guard let url = URL(string: url ?? "") else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))]) 
    }
}
