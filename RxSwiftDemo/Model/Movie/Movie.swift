//
//  Movie.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let name: String?
    let image: MovieImage?
    
    init(id: Int, name: String?, image: MovieImage?) {
        self.id = id
        self.name = name
        self.image = image
    }
}

struct MovieImage: Codable {
    let medium: String?
    let original: String?
}
