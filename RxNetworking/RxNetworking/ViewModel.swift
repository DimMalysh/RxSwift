//
//  ViewModel.swift
//  RxNetworking
//
//  Created by mac on 31.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct ViewModel {
    
    let searchText = Variable("")
    
    let APIProvider: APIProvider
    var data: Driver<[Repository]>
    
    init(APIProvider: APIProvider) {
        self.APIProvider = APIProvider
        
        data = self.searchText.asObservable()
            
        .throttle(0.3, scheduler: MainScheduler.instance).distinctUntilChanged().flatMapLatest {
                APIProvider.getRepositories($0)
            }.asDriver(onErrorJustReturn: [])
    }
    
}
