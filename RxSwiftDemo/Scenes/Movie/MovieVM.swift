//
//  MovieVM.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import RxSwift
import RxCocoa
import RxSwiftExt

class MovieVM {
    
    struct Input { // sequences
        let search: Observable<String>
    }
    
    struct Output { // sequences
        let movies: Driver<[Movie]>
        let loading: Driver<Bool>
        let error: Driver<APIError>
    }
    
    struct Dependencies {
        let service: MovieApiService
    }
    
    func create(input: Input, dependencies: Dependencies) -> Output {
        let loadingTracker = ActivityTracker()
        let errorTracker = ErrorTracker()
        
        let movieEvents = input.search
            .flatMapLatest {
                self.movies(service: dependencies.service, query: $0)
                    .track(loading: loadingTracker)
                    .track(error: errorTracker)
                    .materialize()
            }
            .share()
       
        let movies = movieEvents
            .compactMap({ $0.element })
            .asDriver(onErrorJustReturn: [])
            
        let error = errorTracker
            .asDriver()
            .map(transformApiError)
        
        return .init(movies: movies,
                     loading: loadingTracker.asDriver(),
                     error: error)
    }
    
    func movies(service: MovieApiService, query: String) -> Observable<[Movie]> {
        if query.isEmpty {
            return service.getMovies()
        } else {
            return service.searchMovies(query: query)
                .mapMany({ $0.show })
                .mapMany({ Movie(id: $0.id, name: $0.name, image: $0.image) })
        }
    }
}
