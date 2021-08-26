//
//  Endpoint.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import Foundation

struct Configuration {
    
    static let env: Environment = .development
    
    enum Environment {
        case production
        case development
        
        var host: String {
            switch self {
            case .production:
                return "production-api.tvmaze.com" // demo url
            case .development:
                return "api.tvmaze.com"
            }
        }
    }
}

enum Endpoint {
    
    case getMovies
    case searchMovies
    case getMovieDetail(Int)
    case getPersons
    
    var path: String {
        switch self {
        case .getMovies:
            return "/shows"
        case .searchMovies:
            return "/search/shows"
        case .getMovieDetail(let id):
            return "/shows/\(id)"
        case .getPersons:
            return "search/people"
        }
    }
}
