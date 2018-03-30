//: Playground - noun: a place where people can play

import UIKit
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
example("DisposeBag") {
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

/*
example("merge") {
    let firstSeq = Observable.of(1, 2, 3)
    let secondSeq = Observable.of(4, 5, 6)
    
    let mergeSeq = Observable.of(firstSeq, secondSeq).merge()
    
    mergeSeq.subscribe({ (event) in
        print(event)
    })
}
*/

//MARK: Subjects

/*
example("PublishSubject") {
    let disposeBug = DisposeBag()
    let publishSubject = PublishSubject<String>()
    
    publishSubject.subscribe({ (event) in
        print("Subscription first:", event)
    }).addDisposableTo(disposeBug)
    
    enum MyError: Error {
        case test
    }
    
    publishSubject.on(.next("Hello"))
    //publishSubject.onCompleted()
    //publishSubject.onError(MyError.test)
    publishSubject.onNext("RxSwift")
    
    publishSubject.subscribe(onNext: { (event) in
        print("Subscription second:", event)
    }).addDisposableTo(disposeBug)
    
    publishSubject.onNext("Hi!")
    publishSubject.onNext("Bye!")
}
*/

/*
example("BehaviorSubject") {
    let disposeBug = DisposeBag()
    let behaviorSubject = BehaviorSubject(value: 1) //[1]

    let firstSubscription = behaviorSubject.subscribe(onNext: { (event) in
        print(#line, event)
    }).addDisposableTo(disposeBug)

    behaviorSubject.onNext(2) //[1, 2]
    behaviorSubject.onNext(3) //[1, 2, 3]
    
    let secondSubscription = behaviorSubject.subscribe(onNext: { (event) in
        print(#line, event) //[3]
    }).addDisposableTo(disposeBug)
}
*/

/*
example("ReplaySubject") {
    let disposeBug = DisposeBag()
    let replaySubject = ReplaySubject<String>.create(bufferSize: 1)
    
    replaySubject.subscribe(onNext: { (event) in
        print("Subscription first:", event)
    }).addDisposableTo(disposeBug)
    
    replaySubject.onNext("a")
    replaySubject.onNext("b")
    
    replaySubject.subscribe(onNext: { (event) in
        print("Subscription second:", event)
    }).addDisposableTo(disposeBug)

    replaySubject.onNext("c")
    replaySubject.onNext("d")
    
    
    let anotherReplaySubject = ReplaySubject<Int>.create(bufferSize: 3)
    
    anotherReplaySubject.onNext(1)
    anotherReplaySubject.onNext(2)
    anotherReplaySubject.onNext(3)
    anotherReplaySubject.onNext(4)
    
    anotherReplaySubject.subscribe(onNext: { (event) in
        print("Subscription another first:", event)
    }).addDisposableTo(disposeBug)
}
*/

/*
example("Variables") {
    let disposeBug = DisposeBag()
    let variable = Variable("A")
    
    variable.asObservable().subscribe(onNext: { (event) in
        print(event)
    }).addDisposableTo(disposeBug)
    
    variable.value = "B"
}
*/

//MARK: Side effect

/*
example("SideEffect") {
    let disposeBug = DisposeBag()
    let seq  = [0, 32, 100, -40]
    let tempSeq = Observable.from(seq)
    
    tempSeq.do(onNext: {
        print("\($0)F = ", terminator: "")
    }).map({
        Double($0 - 32) * 5 / 9.0
    }).subscribe(onNext: {
        print(String(format: "%.1f", $0))
    }).addDisposableTo(disposeBug)
}
*/
 
//MARK: Schedulers

/*
example("without observeOn") {
    _ = Observable.of(1, 2, 3)
    
    .subscribe(onNext: {
        print("\(Thread.current)", $0)
    }, onError: nil,
       onCompleted: {
        print("Completed")
    }, onDisposed: nil)
}
*/

/*
example("observeOn") {
    _ = Observable.of(1, 2, 3)
        
    .observeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .background))
        
    .subscribe(onNext: {
        print("\(Thread.current)", $0)
    }, onError: nil,
       onCompleted: {
        print("Completed")
    }, onDisposed: nil)
}
*/

example("subscribeOn and observeOn") {
    let queue1 = DispatchQueue.global(qos: .default)
    let queue2 = DispatchQueue.global(qos: .default)
    
    print("Init Thread: \(Thread.current)")
    
    _ = Observable<Int>.create({ (observer) -> Disposable in
        print("Observable thread: \(Thread.current)")
        
        observer.on(.next(1))
        observer.on(.next(2))
        observer.on(.next(3))
        
        return Disposables.create()
    })
    
    .subscribeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "queue1")).observeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "queue2"))
        
    .subscribe(onNext: {
        print("Observable thread: \(Thread.current)", $0)
    })
}
