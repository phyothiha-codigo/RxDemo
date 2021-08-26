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
import RxKeyboard

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
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var isLoading: Bool = false
    lazy var bag = DisposeBag()
    let vm = LoginVM()
    
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
        
        let formInput = Observable.combineLatest(
            txtUsername.rx.text.orEmpty,
            txtPassword.rx.text.orEmpty.map(digitsOnly).do(onNext: setPreservingCursor(on: txtPassword))
        ).map(LoginVM.FormInput.init)
        
        let input = LoginVM.Input.init(formInput: formInput)
        
        let output = vm.create(input: input)
        
        output.formErrors
            .skip(2)
            .drive(onNext:{
                self.resetErrors()
                $0.forEach { error in
                    switch error.type {
                    case .email:
                        self.lblEmail.textColor = .red
                        self.txtUsername.layer.borderColor = UIColor.red.cgColor
                        break
                    case .password:
                        self.lblPassword.textColor = .red
                        self.txtPassword.layer.borderColor = UIColor.red.cgColor
                        break
                    }
                }
            })
            .disposed(by: bag)
        
        output.enableSubmit
            .drive(rx.isEnable)
            .disposed(by: bag)
        
        txtPassword.rx
            .controlEvent(.editingChanged)
            .map {[unowned self] in String(txtPassword.text?.prefix(15) ?? "")}
            .bind(to: txtPassword.rx.text)
            .disposed(by: bag)
        
        RxKeyboard.instance.visibleHeight
            .drive(rx.keyboardHeightChanged)
            .disposed(by: bag)
        
    }
    @IBAction func gotToMovie(_ sender: Any) {
        routeToMovie()
    }
    
    func resetErrors() {
        lblEmail.textColor = .black
        txtUsername.layer.borderColor = UIColor.black.cgColor
        
        lblPassword.textColor = .black
        txtPassword.layer.borderColor = UIColor.black.cgColor
    }
    
    func routeToMovie() {
        let vc = MovieVC.screen()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        present(nav, animated: true, completion: nil)
    }
    
    func digitsOnly(_ text: String) -> String {
        return text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }

    func setPreservingCursor(on textField: UITextField) -> (_ newText: String) -> Void {
        return { newText in
            let cursorPosition = textField.offset(from: textField.beginningOfDocument,
                                                  to: textField.selectedTextRange!.start) + newText.count - (textField.text?.count ?? 0)
            textField.text = newText
            if let newPosition = textField.position(from: textField.beginningOfDocument, offset: cursorPosition) {
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
        }
    }
}

extension Reactive where Base: LoginVC {
    
    var isEnable: Binder<Bool> {
        return Binder(base) { vc, isValid in
            vc.btnLogin.isEnabled = isValid
            vc.btnLogin.backgroundColor = isValid ? .black : .gray
        }
    }
    
    var keyboardHeightChanged: Binder<CGFloat> {
        return Binder(base) { vc, height in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIView.animate(withDuration: 0.5, animations: {
                    vc.topConstraint.constant = height == 0 ? 52 : 32
                    vc.view.layoutIfNeeded()
                })
            }
            
        }
    }
}
