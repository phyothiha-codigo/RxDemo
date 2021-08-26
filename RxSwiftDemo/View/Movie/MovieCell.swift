//
//  MovieCell.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    
    var movie: Movie? {
        didSet {
            lblMovieName.text = movie?.name
            imgMovie.setImage(url: movie?.image?.medium)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
