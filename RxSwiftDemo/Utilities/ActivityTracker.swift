//
//  ActivityTracker.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import RxSwift
import RxCocoa

class ActivityTracker {
    
    private let loadingSubject = PublishSubject<Bool>()

    func track<T: ObservableConvertibleType>(source: T) -> Observable<T.Element> {
        return source.asObservable().do(onNext: { _ in
            self.onNext(true)
        }, onCompleted: onCompleted)
    }
    
    func asDriver() -> Driver<Bool> {
        return loadingSubject
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
    }
    
    func onNext(_ element: Bool) {
        loadingSubject.onNext(true)
    }
    
    func onCompleted() {
        loadingSubject.onNext(false)
    }
}

