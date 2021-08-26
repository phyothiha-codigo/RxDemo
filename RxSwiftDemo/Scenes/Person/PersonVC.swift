//
//  PersonVC.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 16/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

class PersonVC: UIViewController, AppStoryboard {

    static var storyboard: Storyboard = .main
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblPerson: UITableView!
    
    private var vm: PersonVM?
    private var router: PersonRouter?
    private let bag = DisposeBag()

    private static let cellIdentifier = "PersonCell"
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    func setup() {
        vm = PersonVM()
        router = PersonRouter()
        router?.vc = self
    }
    
    func setupView() {
        // TODO: -
        tblPerson.dataSource = self
        tblPerson.delegate = self
        tblPerson.register(UINib(nibName: "PersonCell", bundle: nil), forCellReuseIdentifier: PersonVC.cellIdentifier)
        tblPerson.keyboardDismissMode = .interactive
    }
    
    func setupBindings() {
        guard let vm = vm else {
            print("❗️VM object is nil!")
            return
        }
        
        // TODO: -
    }
}

extension PersonVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonVC.cellIdentifier, for: indexPath) as! PersonCell
        // TODO: -
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
