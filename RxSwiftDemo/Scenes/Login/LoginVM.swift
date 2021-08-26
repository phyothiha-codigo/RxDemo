//
//  LoginVM.swift
//  RxSwiftDemo
//
//  Created by Codigo Phyo Thiha on 8/26/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

class LoginVM {
    
    typealias ValidationError = [FormType: String]
    
    let required = "required"
    
    enum FormType {
        case email, password
    }
    
    struct FormValidate {
        var type: FormType = .email
        var isSuccess: Bool = false
        var errorMessage: String = ""
    }
    
    struct FormInput {
        let email: String
        let password: String
    }
    
    struct Input {
        let formInput: Observable<FormInput>
        
    }
    
    struct Output {

        let formErrors: Driver<[LoginVM.FormValidate]>
        let enableSubmit: Driver<Bool>
    }
    
    func create(input: Input) -> Output {
        
        let validateRequiredField = input.formInput
            .map(validateRequired)
            .share()
        
        let enableSubmit = validateRequiredField
            .map { $0.filter{ $0.errorMessage !=  ""}.isEmpty}
        
        let formInvalid = validateRequiredField
            .compactMap { $0.filter { !$0.isSuccess} }

        return .init(formErrors: formInvalid.asDriverOnErrorNever(),
                     enableSubmit: enableSubmit.asDriverOnErrorNever())
    }
    
    
    func validateRequired(_ form: FormInput) -> [FormValidate] {
        
        var validator: [FormValidate] = []
        
        let emailVali = validateEmail(message: required)(form.email)
        validator.append(FormValidate(type: .email, isSuccess: emailVali.isSuccess, errorMessage: emailVali.invalid ?? ""))

        let passwordVali = validateNonEmpty(message: required)(form.password)
        validator.append(FormValidate(type: .password, isSuccess: passwordVali.isSuccess, errorMessage: passwordVali.invalid ?? ""))
    
        return validator
    }
}


public extension ObservableType {
    
    static func void() -> Observable<Void> {
        .just(())
    }
    
    func catchErrorJustComplete() -> Observable<Element> {
        self.catch { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { error in
            return Driver.empty()
        }
    }
    
    func asDriverOnErrorNever() -> Driver<Element> {
        asDriver { error in
            return .never()
        }
    }
}
