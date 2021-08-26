//
//  MovieDetailVM.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 13/08/2021.
//

import RxSwift
import RxCocoa
import RxSwiftExt

class MovieDetailVM {
    
    struct Input { // sequences
        let movieId: Observable<Int>
    }
    
    struct Output { // sequences
        let detail: Driver<MovieDetail>
        let loading: Driver<Bool>
        let error: Driver<APIError>
    }
    
    struct Dependencies {
        let service: MovieApiService
    }
    
    func create(input: Input, dependencies: Dependencies) -> Output {
        let loadingTracker = ActivityTracker()
        let errorTracker = ErrorTracker()
        
        let detail = input.movieId
            .flatMap {
                dependencies.service.getMovie(id: $0)
                    .track(loading: loadingTracker)
                    .track(error: errorTracker)
                    .materialize()
            }
            .compactMap({ $0.element })
        
        
        let error = errorTracker
            .asDriver()
            .map(transformApiError)
        
        return .init(detail: detail.asDriver(onErrorDriveWith: .never()),
                     loading: loadingTracker.asDriver(),
                     error: error)
    }
}
