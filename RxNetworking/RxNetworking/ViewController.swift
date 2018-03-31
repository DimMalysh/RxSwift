//
//  ViewController.swift
//  RxNetworking
//
//  Created by mac on 31.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    var repositoriesViewModel: ViewModel?
    let api = APIProvider()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureSearchController()
        
        repositoriesViewModel = ViewModel(APIProvider: api)
        if let viewModel = repositoriesViewModel {
            viewModel.data.drive(tableView.rx.items(cellIdentifier: "Cell")) {_, repository, cell in
                cell.textLabel?.text = repository.name
                cell.detailTextLabel?.text = repository.url
            }.addDisposableTo(disposeBag)
            
            searchBar.rx.text.bindTo(viewModel.searchText).addDisposableTo(disposeBag)
            searchBar.rx.cancelButtonClicked.map{""}.bindTo(viewModel.searchText).addDisposableTo(disposeBag)
            
            viewModel.data.asDriver()
                .map{
                    "\($0.count) Repositories"
            }
            .drive(navigationItem.rx.title)
            .addDisposableTo(disposeBag)
        }
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = true
        searchBar.showsCancelButton = true
        searchBar.text = "DimMalysh"
        searchBar.placeholder = "Enter user"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

}

