//
//  ViewController.swift
//  RxTableViewTest
//
//  Created by mac on 30.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //Create Observable array of elements.
    let food = Observable.just([
        Food(name: "Kids Burger", flickrID: "kids-burger"),
        Food(name: "Lasagna",     flickrID: "lasagna"),
        Food(name: "Sausage",     flickrID: "sausage"),
        Food(name: "Vegetables",  flickrID: "vegetables")
    ])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        food.bindTo(tableView.rx.items(cellIdentifier: "Cell")) { row, foods,
            cell in
            cell.textLabel?.text = foods.name
            cell.detailTextLabel?.text = foods.flickrID
            cell.imageView?.image = foods.image
        }.addDisposableTo(disposeBag)
        
        tableView.rx.modelSelected(Food.self).subscribe(onNext: {
            print("You selected: \($0)")
        }).addDisposableTo(disposeBag)
    }
    
}

/*
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            else {
               return UITableViewCell()
        }
        
        let foods = food[indexPath.row]
        cell.textLabel?.text = foods.name
        cell.detailTextLabel?.text = foods.flickrID
        cell.imageView?.image = foods.image
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(food[indexPath.row])")
    }
}
*/
