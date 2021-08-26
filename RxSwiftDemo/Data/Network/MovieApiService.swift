//
//  MovieApiService.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieApiServiceProtocol {
    func getMovies() -> Observable<[Movie]>
    func searchMovies(query: String) -> Observable<[SearchMovieResponse]>
    func getMovie(id: Int) -> Observable<MovieDetail>
}

class MovieApiService: ApiService, MovieApiServiceProtocol {
    
    static let shared = MovieApiService()
    
    func getMovies() -> Observable<[Movie]> {
        self.executeDataTask(params: nil, endpoint: Endpoint.getMovies)
    }
    
    func searchMovies(query: String) -> Observable<[SearchMovieResponse]> {
        self.executeDataTask(params: ["q": query], endpoint: Endpoint.searchMovies)
    }
    
    func getMovie(id: Int) -> Observable<MovieDetail> {
        self.executeDataTask(params: nil, endpoint: Endpoint.getMovieDetail(id))
    }
}
