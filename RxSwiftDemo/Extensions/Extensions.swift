//
//  Extensions.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import RxSwift
import RxCocoa

extension ObservableConvertibleType {
    func track(error: ErrorTracker) -> Observable<Element> {
        return error.track(source: self)
    }
    func track(loading: ActivityTracker) -> Observable<Element> {
        return loading.track(source: self)
    }
}

extension Error where Self == APIError {
    func message() -> String {
        return self.description
    }
}

extension Reactive where Base: UIViewController {
    
    var viewDidLoad: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }.mapToVoid()
        return ControlEvent(events: source)
    }
    
    var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewDidDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}

public extension ObservableType {

    func mapToVoid() -> Observable<Void> {
        return .just(Void())
    }
}

extension Int {
    func toTimeFormat() {
        
    }
}
