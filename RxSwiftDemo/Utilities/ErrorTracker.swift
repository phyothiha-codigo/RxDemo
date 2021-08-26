//
//  ErrorTracker.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import RxSwift
import RxCocoa

class ErrorTracker {
    
    private let errorSubject = PublishSubject<Error>()
    
    func track<T: ObservableConvertibleType>(source: T) -> Observable<T.Element> {
        return source.asObservable().do(onError: onError)
    }
    
    func asDriver() -> Driver<Error> {
        return errorSubject
            .asDriver(onErrorDriveWith: .never())
    }
    
    func onError(error: Error) {
        errorSubject.onNext(error)
    }
}
