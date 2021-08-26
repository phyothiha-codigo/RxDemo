//
//  SearchMovie.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import Foundation

struct SearchMovieResponse: Codable {
    let score: Double?
    let show: SearchMovie
}

struct SearchMovie: Codable {
    let id: Int
    let name: String?
    let image: MovieImage?
}
