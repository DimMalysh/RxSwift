//: Playground - noun: a place where people can play

import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/*
example("just") {
    //OBSERVABLE
    let observable = Observable.just("Hello, RxSwift!")
    
    //OBSERVER
    observable.subscribe({ (event: Event<String>) in
        print(event)
    })
}
*/

/*
example("of") {
    let observable = Observable.of(1, 2, 3, 4, 5)
 
    observable.subscribe({ (event) in
        print(event)
    })
}
*/

/*
example("create") {
    let items = [1, 2, 3, 4, 5]
    
    Observable.from(items).subscribe(onNext: { (event) in
        print(event)
    }, onError: { (error) in
        print(error)
    }, onCompleted: {
        print("Completed!")
    }, onDisposed: {
        //Release of used resources
        print("Disposed!")
    })
}
*/

/*
example("Disposable") {
    let seq = [1, 2, 3]
    
    Observable.from(seq).subscribe({ (event) in
        print(event)
    })
    
    Disposables.create()
}
*/

/*
example("dispose") {
    let seq = [1, 2, 3]
    let subscription = Observable.from(seq)
    
    subscription.subscribe({ (event) in
        print(event)
    }).dispose()
}
*/

/*
example("disposeBag") {
    let disposeBug = DisposeBag()
    let seq = [1, 2, 3]
    let subscription = Observable.from(seq)
    
    subscription.subscribe({ (event) in
        print(event)
    }).addDisposableTo(disposeBug)
}
*/

/*
example("takeUntil") {
    let stopSeq = Observable.just(1).delaySubscription(2, scheduler: MainScheduler.instance)
    let seq = Observable.from([1, 2, 3]).takeUntil(stopSeq)
    
    seq.subscribe({ (event) in
        print(event)
    })
}
*/

//MARK: Operators

/*
example("filter") {
    let seq = Observable.of(1, 2, 20, 2, 3, 40).filter{$0 > 10}
    
    seq.subscribe({ (event) in
        print(event)
    })
}
*/

/*
example("map") {
    let seq = Observable.of(1, 2, 3).map{$0 * 10}
    
    seq.subscribe({ (event) in
        print(event)
    })
}
*/

example("merge") {
    let firstSeq = Observable.of(1, 2, 3)
    let secondSeq = Observable.of(4, 5, 6)
    
    let mergeSeq = Observable.of(firstSeq, secondSeq).merge()
    
    mergeSeq.subscribe({ (event) in
        print(event)
    })
}
