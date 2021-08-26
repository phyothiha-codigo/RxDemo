import UIKit
import RxSwift
import RxSwiftExt

// just - one time
let bag = DisposeBag()
let greeting = Observable.just("Hi")
//
//greeting.subscribe { item in
//    print("just => \(item)")
//} onError: { error in
//    print("just error => \(error)")
//} onCompleted: {
//    print("just => completed")
//} onDisposed: {
//    print("just => disposed")
//}
//.disposed(by: bag)
//
//// map
//let greetingRxSwift = greeting.map({ $0 + ", RxSwift!" })
//print("--------------------------------------------------------------")
//greetingRxSwift.subscribe { item in
//    print("map => \(item)")
//} onError: { error in
//    print("map error => \(error)")
//} onCompleted: {
//    print("map => completed")
//} onDisposed: {
//    print("map => disposed")
//}
//.disposed(by: bag)
//
//// flatmap
//// Transforms the items emitted by an Observable into Observables, then flatten the emissions from those into a single Observable.
//
//let weekdays = Observable.just(["Mon", "Tues", "Wednes", "Thurs", "Fri"])
//let flatMapResult = weekdays.flatMap { weekdays in
//    Observable.just(weekdays.map({ $0 + "day" }))
//}
//print("--------------------------------------------------------------")
//flatMapResult.subscribe { item in
//    print("flatmap => \(item)")
//} onError: { error in
//    print("flatmap error => \(error)")
//} onCompleted: {
//    print("flatmap => completed")
//} onDisposed: {
//    print("flatmap => disposed")
//}
//.disposed(by: bag)
//
//// sequence filter
//let developers = PublishSubject<String>()
//let mobileDevelopers = developers
//    .filter({ $0.contains("Mobile") })
//
//print("--------------------------------------------------------------")
//
//mobileDevelopers.subscribe { item in
//    print("filter => \(item)")
//} onError: { error in
//    print("filter error => \(error)")
//} onCompleted: {
//    print("filter => completed")
//} onDisposed: {
//    print("filter => disposed")
//}
//.disposed(by: bag)
//
//developers.onNext("C# Developer")
//developers.onNext("iOS Mobile Developer")
//developers.onNext("Java Developer")
//developers.onNext("Android Mobile Developer")
//
//// array filter
//let scores = Observable.just([120, 89, 90, 67, 40, 88, 139])
//let greatScores = scores.map({ $0.filter({ $0 > 100 }) }) //.map({ $0.filter({ $0 > 100 }) })
//
//print("--------------------------------------------------------------")
//greatScores.subscribe { item in
//    print("filter => \(item)")
//} onError: { error in
//    print("filter error => \(error)")
//} onCompleted: {
//    print("filter => completed")
//} onDisposed: {
//    print("filter => disposed")
//}
//.disposed(by: bag)
//
////  DistinctUntilChanged
//let searchQuery = PublishSubject<String>()
//
//print("--------------------------------------------------------------")
//
//searchQuery.distinctUntilChanged().subscribe { item in
//    print("DistinctUntilChanged => \(item)")
//} onError: { error in
//    print("DistinctUntilChanged error => \(error)")
//} onCompleted: {
//    print("DistinctUntilChanged => completed")
//} onDisposed: {
//    print("DistinctUntilChanged => disposed")
//}
//.disposed(by: bag)
//
//
//// Debounce
////print("--------------------------------------------------------------")
////
////searchQuery.distinctUntilChanged()
////    .debounce(.seconds(3), scheduler: MainScheduler.instance)
////    .subscribe { item in
////        print("debounce => \(item)")
////    } onError: { error in
////        print("debounce error => \(error)")
////    } onCompleted: {
////        print("debounce => completed")
////    } onDisposed: {
////        print("debounce => disposed")
////    }
////    .disposed(by: bag)
////
////var counter: Int = 0
////let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
////    counter += 1
////    print("counter \(counter)")
////    if counter >= 5 {
////        timer.invalidate()
////    }
////}
////
////timer.fire()
////
////
////searchQuery.onNext("taylor")
////searchQuery.onNext("taylor")
////searchQuery.onNext("taylor swift")
////searchQuery.onNext("taylor swift")
////searchQuery.onNext("Taemin")
//
//// StartWith
//let meditation = PublishSubject<Int>()
//print("--------------------------------------------------------------")
//meditation.startWith(5).subscribe { item in
//    print("startWith => \(item) minutes")
//} onError: { error in
//    print("startWith error => \(error)")
//} onCompleted: {
//    print("startWith => completed")
//} onDisposed: {
//    print("startWith => disposed")
//}
//.disposed(by: bag)
//
//meditation.onNext(10)
//
//// Zip
//// merge items emitted by different observable sequences to one observable sequence
////let weeks = PublishSubject<String>()
////let months = PublishSubject<String>()
////
////let eventDates = Observable.zip(weeks, months)
////print("--------------------------------------------------------------")
////eventDates.subscribe { item in
////    print("Zip => \(item.0) of \(item.1)")
////} onError: { error in
////    print("Zip error => \(error)")
////} onCompleted: {
////    print("Zip => completed")
////} onDisposed: {
////    print("Zip => disposed")
////}
////.disposed(by: bag)
////
////weeks.onNext("1st week")
////months.onNext("May")
////
////months.onNext("June")
////weeks.onNext("3rd week")
//
//// Merge
//// same type
//let actors = PublishSubject<String>() //Observable.just(["Lee Min Ho", "Park Bo gum"])
//let actresses = PublishSubject<String>() //Observable.just(["Park Shin Hay", "Song Hye Kyo", "Jun Ji Hyun"])
//
//let artists = Observable.merge(actors, actresses)
//
//print("--------------------------------------------------------------")
//artists.subscribe { item in
//    print("Merge => \(item)")
//} onError: { error in
//    print("Merge error => \(error)")
//} onCompleted: {
//    print("Merge => completed")
//} onDisposed: {
//    print("Merge => disposed")
//}
//.disposed(by: bag)
//
//actors.onNext("Lee Min Ho")
//actresses.onNext("Park Shin Hay")
//actresses.onNext("Song Hye Kyo")
//
//// CombineLatest
//struct Voucher {
//    let id: Int
//    let code: String
//}
//
//struct Campaign {
//    let id: Int
//    let name: String
//}
//
//let vouchers = PublishSubject<Voucher>()
//let campaigns = PublishSubject<Campaign>()
//
//let combineResult = Observable.combineLatest(vouchers, campaigns)
//print("--------------------------------------------------------------")
//combineResult.subscribe { voucher, campaign in
//    print("CombineLatest Voucher => \(voucher.code)")
//    print("CombineLatest Campaign => \(campaign.name)")
//} onError: { error in
//    print("CombineLatest error => \(error)")
//} onCompleted: {
//    print("CombineLatest => completed")
//} onDisposed: {
//    print("CombineLatest => disposed")
//}
//.disposed(by: bag)
//
//let voucher1 = Voucher(id: 1, code: "S990")
//let voucher2 = Voucher(id: 2, code: "R993")
//
//let campaign1 = Campaign(id: 1, name: "Campaign One")
//let campaign2 = Campaign(id: 2, name: "Campaign Two")
//
//
//vouchers.onNext(voucher1)
//vouchers.onNext(voucher2)
//
//campaigns.onNext(campaign1)
//campaigns.onNext(campaign2)

let marks = PublishSubject<Int>()
let sharedMarks = marks.share()

marks.subscribe { item in
    print("marks => \(item)")
} onError: { error in
} onCompleted: {
} onDisposed: {
}
.disposed(by: bag)

sharedMarks.subscribe { item in
    print("item1 => \(item)")
} onError: { error in
} onCompleted: {
} onDisposed: {
}
.disposed(by: bag)

sharedMarks.subscribe { item in
    print("item2 => \(item)")
} onError: { error in
} onCompleted: {
} onDisposed: {
}
.disposed(by: bag)

marks.onNext(10)
marks.onNext(200)
