//
//  PersonCell.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 16/08/2021.
//

import UIKit
import Cosmos

class PersonCell: UITableViewCell {

    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblPersonName: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var ratingBar: CosmosView!
    
    var data: PersonData? {
        didSet {
            guard let data = data else { return }
            imgPerson.setImage(url: data.person?.image?.medium)
            lblPersonName.text = data.person?.name
            lblDob.text = data.person?.birthday
            ratingBar.rating = data.score
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
