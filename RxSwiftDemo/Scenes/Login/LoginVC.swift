//
//  LoginVC.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 11/08/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

let requiredUserNameLength = 5
let requiredPasswordLength = 5

let limitUserNameLength = 20

class LoginVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgClock: UIImageView!
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    
    var isLoading: Bool = false
    lazy var bag = DisposeBag()
    
    private enum Control: String {
        case titleLabel
        case usernameField
        case passwordField
        case loginButton
        case clockImage
        case personImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    private func setupView() {
        imgPerson.alpha = 0
        imgClock.alpha = 0
        
        btnLogin.layer.cornerRadius = 2
        btnLogin.backgroundColor = UIColor.black
        
        txtUsername.layer.borderWidth = 1
        txtPassword.layer.borderWidth = 1
        
        txtUsername.layer.cornerRadius = 2
        txtPassword.layer.cornerRadius = 2
        
        txtUsername.layer.borderColor = UIColor.black.cgColor
        txtPassword.layer.borderColor = UIColor.black.cgColor
        
        txtUsername.becomeFirstResponder()
        
    }
    
    private func setupBindings() {
        
        let userNameValidaton = txtUsername.rx.text.orEmpty
            .do(onNext:{_ in self.lblEmail.textColor = .black })
            .map { $0.count >= requiredUserNameLength }
            .share()
        
        let invalidUserName = userNameValidaton
                .filter { !$0}
                .map {_ in  UIColor.red }
        
        let passwordValidation = txtPassword.rx.text.orEmpty
            .do(onNext:{_ in self.lblPassword.textColor = .black })
            .map { $0.count >= requiredPasswordLength }
            .share()
        
        let invalidPassword = passwordValidation
                .filter { !$0}
                .map {_ in  UIColor.red }
        
        let allValid = Observable
            .combineLatest(userNameValidaton, passwordValidation) { $0 && $1}
            .debug()
        
        allValid
            .bind(to: btnLogin.rx.isEnabled)
            .disposed(by: bag)
        
        invalidUserName
            .skip(1)
            .bind(to: self.lblEmail.rx.textColor)
            .disposed(by: bag)
        
        invalidPassword
            .skip(1)
            .bind(to: self.lblPassword.rx.textColor)
            .disposed(by: bag)
        
    }
    
    @IBAction func login(_ sender: Any) {
        routeToMovie()
    }
    
    func routeToMovie() {
        let vc = MovieVC.screen()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        present(nav, animated: true, completion: nil)
    }
}
