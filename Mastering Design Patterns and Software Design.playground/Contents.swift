import UIKit

// MARK: Section 20: Observer Design Pattern (Behavioral)

protocol Observer {
    var id: Int { get }
    func notify(data: String)
}

protocol Subject {
    var observers: [Observer] { get set }
    func registerObserver(observer: any Observer)
    func unregisterObserver(observer: any Observer)
    func notifyAll()
    var mobile: String { get set }
}

class Student: Observer {
    var id: Int
    var name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    func notify(data: String) {
        print("[\(id)] The updated mobile number is \(data)")
    }
}

class Teacher: Subject {
    // 구독 중인 객체들
    var observers: [any Observer] = []
    var mobile: String {
        didSet {
            // mobile 상태 변경 마다, 구독자들에게 변경된 상태가 전달된다.
            notifyAll()
        }
    }
    var name: String

    init(mobile: String, name: String) {
        self.mobile = mobile
        self.name = name
    }

    /// 옵저버 구독
    func registerObserver(observer: any Observer) {
        observers.append(observer)
    }

    /// 옵저버 구독해지
    func unregisterObserver(observer: any Observer) {
        for (index, object) in observers.enumerated()
        where object.id == observer.id {
            observers.remove(at: index)
        }
    }

    /// 구독된 옵저버들에 알림 통보
    func notifyAll() {
        observers.forEach {
            $0.notify(data: mobile)
        }
    }
}

var teacher: Subject = Teacher(mobile: "010-1234-5678", name: "Min")
let firstStudent: Observer = Student(id: 1, name: "first student")
let secondStudent: Observer = Student(id: 2, name: "second student")
let thirdStudent: Observer = Student(id: 3, name: "thrid student")
teacher.registerObserver(observer: firstStudent)
teacher.registerObserver(observer: secondStudent)
teacher.registerObserver(observer: thirdStudent)
// 상태 변경 시, observer들에게 변경된 상태 전달
teacher.mobile = "010-4321-8765"

// - Output Example, 변경된 상태가 observer들에게 전달 됨
// [1] The updated mobile number is 010-4321-8765
// [2] The updated mobile number is 010-4321-8765
// [3] The updated mobile number is 010-4321-8765

/*

// MARK: Section 19: Template Design Pattern (Behavioral)
// - protocol extension method 및 shadowing 활용한 task step 설정 패턴

protocol Bake {
    func mix()
    func boil()
    func garnish()

    func make()
}

extension Bake {
    func make() {
        // algorithm step을 지정
        mix() // 섞고
        boil() // 끓이고
        garnish() // 장식
    }
}

class Pizza: Bake {
    func mix() {
        print("Mix")
    }
    
    func boil() {
        print("Boil")
    }
    
    func garnish() {
        print("Garnish")
    }
}

class Cake: Bake {
    func mix() {
        print("Mix")
    }

    func boil() {
        print("Boil")
    }

    func garnish() {
        print("Garnish")
    }

    // Pizza 조리법에 맞게 step을 수정 가능하다.
    // make를 정의해서 step 수정
    func make() {
        boil() // 끓이고
        mix() // 섞고
        garnish() // 장식
    }
}

class Restaurant {
    func createCake() {
        let bake: Bake = Cake()
        bake.make()
    }

    func createPizza() {
        let bake: Bake = Pizza()
        bake.make()
    }
}

let restaurant: Restaurant = Restaurant()
restaurant.createCake()

*/

/*

// MARK: Section 18: Strategy Design Pattern (Behavioral)

// DB에서 수행할 4가지 동작, 프로토콜에 모든 동작이 정의되어있음
protocol DBOperations {
    func create()
    func update()
    func delete()
    func read()
}

class RemoteDB: DBOperations {
    func create() {
        print("Create from Remote DB")
    }
    
    func update() {
        print("Update from Remote DB")
    }
    
    func delete() {
        print("Delete from Remote DB")
    }
    
    func read() {
        print("Read from Remote DB")
    }
}

class LocalDB: DBOperations {
    func create() {
        print("Create from Local DB")
    }

    func update() {
        print("Update from Local DB")
    }

    func delete() {
        print("Delete from Local DB")
    }

    func read() {
        print("Read from Local DB")
    }
}

class Storage {
    private let database: any DBOperations

    init(database: DBOperations) {
        self.database = database
    }

    func create() {
        database.create()
    }

    func update() {
        database.update()
    }

    func delete() {
        database.delete()
    }

    func read() {
        database.read()
    }
}

enum Environment {
    case develop
    case production
}

let environment: Environment = .develop
// environment type에 따라 그에 맞게 DBOperations를 준수하는 구현체 준비
var database: any DBOperations = (environment == .develop ? LocalDB() : RemoteDB())
// environment type에 맞는 database를 Storage에 주입
let storage: Storage = Storage(database: database)
// develop environment에 맞게 DBOperations를 준수하는 LocalDB 기준으로 동작 실행
storage.create()
storage.update()
storage.delete()
storage.read()

*/

/*

// MARK: Section 17: Chain of Responsibility (Behavioral)

protocol Deducatable: AnyObject {
    var next: Deducatable? { get set }

    func deduct(amount: Double)
    static func createChain() -> Deducatable
}

extension Deducatable {
    static func createChain() -> Deducatable {
        let savingAccount: Deducatable = SavingAccount()
        let fixedAccount: Deducatable = FixedAccount()
        let currentAccount: Deducatable = CurrentAccount()

        savingAccount.next = fixedAccount
        fixedAccount.next = currentAccount

        return savingAccount
    }
}

class SavingAccount: Deducatable {
    var next: Deducatable?

    func deduct(amount: Double) {
        // deduct 가능하면 수행하고, 안되면 next Deducatable로 넘긴다.
        if amount <= 1000 {
            print("Amount deducted from Saving Account")
        } else {
            next?.deduct(amount: amount)
        }
    }
}

class FixedAccount: Deducatable {
    var next: Deducatable?

    func deduct(amount: Double) {
        if 1001.0...100000.0 ~= amount {
            print("Amount deducted from Fixed Account")
        } else {
            next?.deduct(amount: amount)
        }
    }
}

class CurrentAccount: Deducatable {
    var next: Deducatable?

    func deduct(amount: Double) {
        if amount > 100000 {
            print("Amount deducted from Current Account")
        } else {
            next?.deduct(amount: amount)
        }
    }
}

class Customer {
    var name: String

    init(name: String) {
        self.name = name
    }

    func deductAmount(amount: Double) {
        let account: Deducatable = SavingAccount.createChain()
        // Chain 내 객체 중, amount 에 맞는 객체가 호출
        account.deduct(amount: amount)
    }
}

let customer: Customer = Customer(name: "Min")
customer.deductAmount(amount: 100)
customer.deductAmount(amount: 10000)
customer.deductAmount(amount: 1000000)

// - Output Example
// Amount deducted from Saving Account
// Amount deducted from Fixed Account
// Amount deducted from Current Account

*/

/*

// MARK: Section 16: FlyWeight Design Pattern (Structural)

protocol Pen {
    var brush: String { get }
    var color: String { get }

    func draw(content: String, color: String)
}

// 아래 Pen protocol을 채택한 3개 구현체는 FlyWeight Object입니다.

class ThickPen: Pen {
    // intrinsic state, 내부 고정 상태
    var brush: String = "Thick"

    var color: String

    init(color: String) {
        // extrinsic state, 외부에서 주입되는 가변 상태
        self.color = color
    }

    func draw(content: String, color: String) {
        print("Drawing content \(content) in \(color)")
    }
}

class ThinPen: Pen {
    var brush: String = "Thin"

    var color: String

    init(color: String) {
        self.color = color
    }

    func draw(content: String, color: String) {
        print("Drawing content \(content) in \(color)")
    }
}

class MediumPen: Pen {
    var brush: String = "Medium"

    var color: String

    init(color: String) {
        self.color = color
    }

    func draw(content: String, color: String) {
        print("Drawing content \(content) in \(color)")
    }
}

class PenFactory {
    nonisolated(unsafe) static var cache: [String: Pen] = [:]

    // 다수의 호출이 있어도, 이미 존재하는 Pen은 단 한번만 생성 및 캐싱 후 사용됩니다.
    static func getPen(brush: String, color: String) -> Pen {
        let key = "\(brush)-\(color)"
        if let pen = PenFactory.cache[key] {
            // 이미 존재하는 pen이면, 기존 캐시의 pen을 사용
            print("Returning the existing Pen from cache")
            return pen
        } else {
            // 없는 pen은 생성 후, 캐싱 및 반환
            print("Creating a new Pen with brush \(brush) and color \(color)")

            let pen: Pen = switch brush {
            case "Thick":
                ThickPen(color: color)
            case "Thin":
                ThinPen(color: color)
            case "Medium":
                MediumPen(color: color)
            default:
                fatalError("There is no such brush implementation")
            }

            cache[key] = pen
            return pen
        }
    }
}

// brush, color 가 같은 객체는 2개 이상 생성되지 않음
let pen: Pen = PenFactory.getPen(brush: "Thick", color: "Red")
let samePen: Pen = PenFactory.getPen(brush: "Thick", color: "Red")

let yelloThinPen: Pen = PenFactory.getPen(brush: "Thin", color: "Yellow")
let yelloThickPen: Pen = PenFactory.getPen(brush: "Thick", color: "Yellow")
let sameYelloThickPen: Pen = PenFactory.getPen(brush: "Thick", color: "Yellow")
sameYelloThickPen.draw(content: "Hello World", color: "Yellow")

// - Output Example
// Creating a new Pen with brush Thick and color Red
// Returning the existing Pen from cache
// Creating a new Pen with brush Thin and color Yellow
// Creating a new Pen with brush Thick and color Yellow
// Returning the existing Pen from cache
// Drawing content Hello World in Yellow

*/

/*

// MARK: Section 15: Decorator Design Pattern (Structural)

protocol Dress {
    func assemble()
}

class BasicDress: Dress {
    func assemble() {
        print("Basic dress features")
    }
}

/// Decorator 부모클래스
class DressDecorator: Dress {
    var dress: Dress

    init(dress: Dress) {
        self.dress = dress
    }

    func assemble() {
        dress.assemble()
    }
}

class CasualDress: DressDecorator {
    override init(dress: any Dress) {
        super.init(dress: dress)
    }

    override func assemble() {
        super.assemble()
        print("Casual Dress Features")
    }
}

class FancyDress: DressDecorator {
    override init(dress: any Dress) {
        super.init(dress: dress)
    }

    override func assemble() {
        super.assemble()
        print("Fancy Dress Features")
    }
}

class SportyDress: DressDecorator {
    override init(dress: any Dress) {
        super.init(dress: dress)
    }

    override func assemble() {
        super.assemble()
        print("Sporty Dress Features")
    }
}

// let fancySporty: Dress = FancyDress(dress: SportyDress(dress: BasicDress()))
// fancySporty.assemble()

// 아래와 같이 mix and match, 여러 Decorator 조합을 포함한 인스턴스 생성이 가능
// BasicDress -> SportyDress -> FancyDress 순으로 assemble 메서드가 호출
let casualSporty: Dress = CasualDress(dress: SportyDress(dress: BasicDress()))
casualSporty.assemble()

// output example
// Basic dress features
// Sporty Dress Features
// Casual Dress Features

*/

/*

// MARK: Section 14: Facade Design Pattern (Structural)

protocol Shape {
    func draw()
}

class Circle: Shape {
    func draw() {
        print("Circle drawn...")
    }
}

class Square: Shape {
    func draw() {
        print("Square drawn...")
    }
}

class Rectangle: Shape {
    func draw() {
        print("Rectangle Drawn...")
    }
}

class ShapeFacade {
    private var circle: Shape = Circle()
    private var square: Shape = Square()
    private var rectangle: Shape = Rectangle()

    func drawCircle() {
        circle.draw()
    }

    func drawRetangle() {
        rectangle.draw()
    }

    func drawSquare() {
        square.draw()
    }
}

// ShapeMaker는 circle, rectangle, square 등의 클래스에 대한 직접적인 의존성을 갖지 않습니다.
class ShapeMaker {
    /// facade 내에서 circle, square, rectangle 등의 클래스 호출을 관리
    var shapeFacade: ShapeFacade = ShapeFacade()

    func drawCircle() {
        shapeFacade.drawCircle()
    }

    func drawRetangle() {
        shapeFacade.drawRetangle()
    }

    func drawSquare() {
        shapeFacade.drawSquare()
    }
}

let maker = ShapeMaker()
maker.drawCircle()
maker.drawSquare()
maker.drawRetangle()

*/

/*

// MARK: Section 13: Proxy Design Pattern (Structural)

protocol AppFeature {
    func upload()
    func download()
    func post()
    func comment()
}

/// 응용 프로그램 클래스
class Application: AppFeature {
    func upload() {
        print("Upload successful")
    }
    
    func download() {
        print("Download successful")
    }
    
    func post() {
        print("Post successful")
    }
    
    func comment() {
        print("Comment successful")
    }
}

protocol ApplicationProxyProtocol {
    func upload(user: User)
    func download(user: User)
    func post(user: User)
    func comment(user: User)
}

class ApplicationProxy: ApplicationProxyProtocol {
    // application 에 접근하기 위해서는 ApplicationProxy를 거쳐야만 합니다.
    // 권한이 있는 경우에만 접근 및 사용이 가능할 수 있습니다.
    private let application: Application = Application()

    func upload(user: User) {
        if user.permissions.contains("upload") {
            application.upload()
        } else {
            print("No upload permission")
        }
    }

    func download(user: User) {
        if user.permissions.contains("download") {
            application.download()
        } else {
            print("No download permission")
        }
    }

    func post(user: User) {
        if user.permissions.contains(("post")) {
            application.post()
        } else {
            print("No post permission")
        }
    }

    func comment(user: User) {
        if user.permissions.contains("comment") {
            application.comment()
        } else {
            print("No comment permission")
        }
    }
}

class User {
    var name: String
    /// 유저의 권한에 맞게 proxy를 통해 application 접근이 가능
    var permissions: [String]
    var applicationProxy: ApplicationProxyProtocol = ApplicationProxy()

    init(name: String, permissions: [String]) {
        self.name = name
        self.permissions = permissions
    }

    func performUpload() {
        applicationProxy.upload(user: self)
    }

    func performDownload() {
        applicationProxy.download(user: self)
    }

    func post() {
        applicationProxy.post(user: self)
    }

    func comment() {
        applicationProxy.comment(user: self)
    }
}

let user: User = User(name: "Min", permissions: ["upload", "download"])
user.performUpload() // upload 가능
user.performDownload() // download 가능
user.post() // post 권한 없어서 접근 불가
user.comment() // comment 권한 없어서 접근 불가
*/

/*

// MARK: Section 12: Composite Pattern (Structural)
// 트리구조 내 Composite, Leaf 객체로 구성된다.

protocol CarPart {
    var name: String { get }
    var price: Double { get }
}

class IndividualPart: CarPart {
    var name: String
    var price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}

class CompositePart: CarPart {
    var name: String
    var price: Double {
        return parts.reduce(0) { $0 + $1.price }
    }
    var parts: [CarPart] = []
    
    init(name: String, parts: [CarPart]) {
        self.name = name
        self.parts = parts
    }

    func addPart(_ part: CarPart) {
        parts.append(part)
    }

    func removePart(_ part: CarPart) {
        for index in parts.indices
        where parts[index].name == part.name {
            parts.remove(at: index)
        }
    }
}

class Customer {
    var name: String
    var parts: [CarPart]

    var totalOrderPrice: Double {
        return parts.reduce(0) { $0 + $1.price }
    }

    init(name: String, parts: [CarPart]) {
        self.name = name
        self.parts = parts
    }

    // Composite, Leaf object 모두 CarPart 를 준수한 상태로 트리구조의 처리가 가능
    func printOrderDetails() {
        print("These are the Part prices")
        for part in parts {
            print("name: \(part.name), price: \(part.price)")
        }
        print("Total Order Price is \(totalOrderPrice)")
    }
}

let windowDoor: CompositePart = CompositePart(
    name: "Window Door",
    parts: [
        IndividualPart(name: "Window Glass", price: 1000),
        IndividualPart(name: "Switch", price: 500),
    ]
)

let door: CompositePart = CompositePart(
    name: "Door",
    parts: [
        windowDoor,
        IndividualPart(name: "Handler", price: 300)
    ]
)
let seatCover: CarPart = IndividualPart(name: "Seat Cover", price: 2000)

let customer = Customer(
    name: "Joe",
    parts: [
        door,
        seatCover
    ]
)

// customer 내 leaf들 price 정보 출력 Composite, Leaf 모두 CarPart를 준수하며, 트리구조로 관리 됨
customer.printOrderDetails()

// Output example)
// These are the Part prices
// name: Door, price: 1800.0
// name: Seat Cover, price: 2000.0
// Total Order Price is 3800.0

 */

/*

// MARK: Section 11: Bridge Pattern (Structural)

protocol TV {
    var remote: Remote { get }
    func on()
    func off()
}

class SonyTV: TV {
    var remote: any Remote

    init(remote: any Remote) {
        self.remote = remote
    }

    func on() {
        print("\(String(describing: Self.self)) on")
    }

    func off() {
        print("\(String(describing: Self.self)) off")
    }
}

class SamsungTV: TV {
    var remote: any Remote

    init(remote: any Remote) {
        self.remote = remote
    }

    func on() {
        print("\(String(describing: Self.self)) on")
    }

    func off() {
        print("\(String(describing: Self.self)) off")
    }
}

protocol Remote {
    func increaseVolume()
    func decreaseVolume()
    func on()
    func off()
}

class BasicRemote: Remote {
    func increaseVolume() {
        print("Volume increased...")
    }
    
    func decreaseVolume() {
        print("Volume decreased...")
    }
    
    func on() {
        print("TV on from \(String(describing: Self.self))")
    }
    
    func off() {
        print("TV off from \(String(describing: Self.self))")
    }
}

class AdvancedRemote: Remote {
    func increaseVolume() {
        print("Volume increased...")
    }

    func decreaseVolume() {
        print("Volume decreased...")
    }

    func on() {
        print("TV on from \(String(describing: Self.self))")
    }

    func off() {
        print("TV off from \(String(describing: Self.self))")
    }

    func channelUp() {
        print("Channel Up")
    }

    func channelDown() {
        print("Channel Down")
    }
}

// 새로 추가한 Remote를 준수하는 SmartRemote
class SmartRemote: Remote {
    func increaseVolume() {
        print("Volume increased...")
    }

    func decreaseVolume() {
        print("Volume decreased...")
    }

    func on() {
        print("TV on from \(String(describing: Self.self))")
    }

    func off() {
        print("TV off from \(String(describing: Self.self))")
    }

    func channelUp() {
        print("Channel Up")
    }

    func channelDown() {
        print("Channel Down")
    }
}

// let tv: TV = SonyTV(remote: SmartRemote())
let tv: TV = SamsungTV(remote: SmartRemote())
// 1) Remote 를 준수하는 구현체 종류에 따라 on, off 출력값이 다름
// 2) Remote를 준수하는 클래스를 추가하는 방식으로 확장이 가능
// -> 상속 대신, 프로토콜을 활용한 컴포지션을 사용하면 보다 유연한 확장이 가능
tv.remote.on()
tv.remote.off()
*/

/*

// MARK: Section 10: Adapter Pattern (Structural)

protocol BasicMobile {
    func initiateCall()
    func disconnectCall()
}

// BasicMobile을 채택하는 Nokia
class Nokia: BasicMobile {
    func initiateCall() {
        print("Call initiated...")
    }

    func disconnectCall() {
        print("Call disconnected...")
    }
}

protocol SmartMobile {
    func startCall()
    func stopCall()
    func capturePhoto()
    func captureVideo()
}

// SmartMobile을 채택하는 IPhone
class IPhone: SmartMobile {
    func startCall() {
        print("Call started...")
    }
    
    func stopCall() {
        print("Call stopped...")
    }
    
    func capturePhoto() {
        print("Capturing Photo...")
    }
    
    func captureVideo() {
        print("Capturing Video...")
    }
}

// BasicMobile 타입을 받아서 SmartMobile 타입으로 사용할 수 있도록 해주는 Adapter
class SmartAdapter: SmartMobile {
    var basicMobile: BasicMobile

    init(basicMobile: BasicMobile) {
        self.basicMobile = basicMobile
    }

    func startCall() {
        self.basicMobile.initiateCall()
    }

    func stopCall() {
        self.basicMobile.disconnectCall()
    }

    func capturePhoto() {
        print("Doesnt support Photo feature")
    }

    func captureVideo() {
        print("Doesnt support Video feature")
    }
}

// 1) SmartAdapter가 없는 경우
// let basicMobile: BasicMobile = Nokia()
// basicMobile은 SmartMobile을 채택하지 않았으므로, 아래 컴파일 에러 발생
// let smartMobile: SmartMobile = basicMobile

// 2) SmartAdapter가 있는 경우
let basicMobile: BasicMobile = Nokia()
// Adapter로 SmartMobile 인스턴스로 변환하여 사용 가능
let smartMobile: SmartMobile = SmartAdapter(basicMobile: basicMobile)
smartMobile.startCall()
smartMobile.stopCall()
smartMobile.captureVideo()
smartMobile.capturePhoto()

*/

/*

// MARK: Section 8: Object Pool Design Pattern (Creational)

class Book {
    var title: String
    var author: String

    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}

// BookPool은 통해 Book을 관리하고, 재사용한다. 재사용으로 비싼 초기화 비용을 줄이고, 유연성을 올린다.
class BookPool {
    var books: [Book]

    init(books: [Book]) {
        self.books = books
    }

    // 기존에 있는 인스턴스를 반환, 생성로직을 숨긴다.
    func getBook() -> Book? {
        if books.isEmpty {
            print("Pool is empty")
            return nil
        }
        print("Book has given.")
        return books.removeFirst()
    }

    func returnBook(book: Book) {
        books.append(book)
    }
}

let bookPool = BookPool(books: [Book(title: "Book of Life", author: "EI"), Book(title: "Book of Love", author: "AB"), Book(title: "Book of Death", author: "CD")])
// bookPool에 책이 존재하면 첫번째 책을 빼내어서(removeFirst) 반환, 없으면 nil 반환
let book1 = bookPool.getBook()
let book2 = bookPool.getBook()
let book3 = bookPool.getBook()
let book4 = bookPool.getBook() // 더이상 book이 없으므로 nil 반환

// returnBook으로 특정 Book 인스턴스를 pool에 추가해서 관리할 수 있다.
bookPool.returnBook(book: book1!) // book1을 pool에 재추가
let book5 = bookPool.getBook() // book5는 기존의 book1 인스턴스를 받는다.
let book6 = bookPool.getBook() // 다시 book이 pool에 없으므로, nil 반환
*/

/*

// MARK: Section 7: Builder Pattern Implementation (Creational)

class Burger {
    var name: String
    var toppings: Bool
    var ketchep: Bool
    var isVeg: Bool
    var isSpicy: Bool
    var cheese: Bool

    init(name: String, toppings: Bool, ketchep: Bool, isVeg: Bool, isSpicy: Bool, cheese: Bool) {
        self.name = name
        self.toppings = toppings
        self.ketchep = ketchep
        self.isVeg = isVeg
        self.isSpicy = isSpicy
        self.cheese = cheese
    }
}

let burger = Burger(name: "My Favorite", toppings: true, ketchep: false, isVeg: true, isSpicy: false, cheese: true)

class BurderBuilder {
    // default values
    var toppings: Bool = true
    var ketchep: Bool = true
    var isVeg: Bool = true
    var isSpicy: Bool = false
    var cheese: Bool = true

    func set(toppings: Bool) {
        self.toppings = toppings
    }

    func set(ketchep: Bool) {
        self.ketchep = ketchep
    }

    func set(isVeg: Bool) {
        self.isVeg = isVeg
    }

    func set(isSpicy: Bool) {
        self.isSpicy = isSpicy
    }

    func set(cheese: Bool) {
        self.cheese = cheese
    }

    func buildBurder(name: String) -> Burger {
        return Burger(name: name, toppings: self.toppings, ketchep: self.ketchep, isVeg: self.isVeg, isSpicy: self.isSpicy, cheese: self.cheese)
    }
}

// Builder Pattern 객체 생성 및 사용 예시
// 초기 생성시에는 하위 멤버 값이 default value로 설정된다.
let burgerBuilder = BurderBuilder()

// 필요에 따라 다른 멤버 값을 추가 변경
burgerBuilder.set(toppings: false)
burgerBuilder.set(ketchep: true)
burgerBuilder.set(isVeg: false)
burgerBuilder.set(isSpicy: true)
burgerBuilder.set(cheese: false)

let myBurger = burgerBuilder.buildBurder(name: "My Favorite Burger")
print(myBurger.isVeg)
print(myBurger.isSpicy)
*/

/*

// MARK: Section 6: Abstract Factory Design Pattern (Creational Design Pattern)

class Computer {
    var cpu: any CPU
    var gpu: any GPU
    var display: any Display

    init(cpu: any CPU, gpu: any GPU, display: any Display) {
        self.cpu = cpu
        self.gpu = gpu
        self.display = display
    }
}

protocol CPU {
    var cores: Int { get }
}

protocol GPU {
    var speed: Int { get }
}

protocol Display {
    var resolution: Int { get }
}

// CPU Concreate Implementations

class BasicCPU: CPU {
    var cores: Int = 2
}

class StandardCPU: CPU {
    var cores: Int = 4
}

class AdvancedCPU: CPU {
    var cores: Int = 8
}

// GPU Concrete Implementations

class BasicGPU: GPU {
    var speed: Int = 1000
}

class StandardGPU: GPU {
    var speed: Int = 5000
}

class AdvancedGPU: GPU {
    var speed: Int = 10000
}

// Display Concreate Implementations

class BasicDisplay: Display {
    var resolution: Int = 100
}

class StandardDisplay: Display {
    var resolution: Int = 500
}

class AdvancedDisplay: Display {
    var resolution: Int = 1000
}

enum Specification {
    case basic, standard, advanced
}

class ComputerFactory {
    func createCPU() -> CPU {
        fatalError("Not Implemented.")
    }

    func createGPU() -> GPU {
        fatalError("Not Implemented.")
    }

    func createDisplay() -> Display {
        fatalError("Not Implemented.")
    }

    static func makeComputerFactory(specification: Specification) -> ComputerFactory? {
        var factory: ComputerFactory?

        switch specification {
        case .basic:
            factory = BasicComputerFactory()
        case .standard:
            factory = StandardComputerFactory()
        case .advanced:
            factory = AdvancedComputerFactory()
        }

        return factory
    }
}

class BasicComputerFactory: ComputerFactory {
    override func createCPU() -> CPU {
        BasicCPU()
    }

    override func createGPU() -> GPU {
        BasicGPU()
    }

    override func createDisplay() -> Display {
        BasicDisplay()
    }
}

class StandardComputerFactory: ComputerFactory {
    override func createCPU() -> CPU {
        StandardCPU()
    }

    override func createGPU() -> GPU {
        StandardGPU()
    }

    override func createDisplay() -> Display {
        StandardDisplay()
    }
}

class AdvancedComputerFactory: ComputerFactory {
    override func createCPU() -> CPU {
        AdvancedCPU()
    }

    override func createGPU() -> GPU {
        AdvancedGPU()
    }

    override func createDisplay() -> Display {
        AdvancedDisplay()
    }
}

if let factory = ComputerFactory.makeComputerFactory(specification: .basic) {
    // enum case에 맞는 Factory를 이용해 그에 맞는 Computer 생성
    let computer = Computer(cpu: factory.createCPU(), gpu: factory.createGPU(), display: factory.createDisplay())

    print(computer.cpu.cores)
    print(computer.gpu.speed)
    print(computer.display.resolution)
}
*/

/*

// MARK: Section 5: Factory Design Pattern (Creational Design Pattern)

class Person {
    var name: String
    /// Mobile protocol 타입의 의존성을 갖는다. Apple, Samsung type 등이 될 수 있다. -> Person은 Mobile의 세부정보는 알 수 없어요.
    var mobile: Mobile

    init(name: String, mobile: Mobile) {
        self.name = name
        self.mobile = mobile
    }
}

protocol Mobile {
    var os: String { get }
    var color: String { get }
    var cost: Double { get }
}

class Apple: Mobile {
    var os: String
    var color: String
    var cost: Double
    
    init(os: String, color: String, cost: Double) {
        self.os = os
        self.color = color
        self.cost = cost
    }
}

class Samsung: Mobile {
    var os: String
    var color: String
    var cost: Double

    init(os: String, color: String, cost: Double) {
        self.os = os
        self.color = color
        self.cost = cost
    }
}

enum Brand {
    case Apple, Samsung
}

class MobileFactory {
    // 사양에 따라 Mobile타입을 준수하는 구현체를 반환한다.
    static func makeMobile(brand: Brand) -> Mobile? {
        var mobile: Mobile?
        switch brand {
        case .Apple:
            mobile = Apple(os: "iOS", color: "Zet Black", cost: 500000)
        case .Samsung:
            mobile = Samsung(os: "Android", color: "White", cost: 250000)
        }

        return mobile
    }
}

let person: Person = .init(name: "Joe", mobile: MobileFactory.makeMobile(brand: .Apple)!)
// person 인스턴스의 mobile은 프로토콜 타입으로 구체적인 타입을 알 수 없습니다. 이는 구체적인 타입의 변경에 대한 의존성을 줄여주고, Mobile 프로토콜만 준수하면 새로운 구현체도 추가할 수 있습니다. (확장성 증가)
print(person.mobile.os)
print(person.mobile.color)
print(person.mobile.cost)
*/

/*

// MARK: Section 4: System Design Fundamentals & Terminology

// 시스템 내에서의 목적을 달성하기 위해서는 많은 객체 간에 의존성이 생깁니다.
// 의존성이 생기는 경우, 객체의 변화에 대한 수정사항이 많이 발생할 수 있으므로 주의가 필요합니다.

class Person {
    var name: String

    init(name: String) {
        self.name = name
    }

    func eat() {
        // Person은 IceCream에 대한 의존성이 생겼어요.
        let iceCream = IceCream(flavour: "berry")
        iceCream.finish()
    }
}

class IceCream {
    var flavour: String
    // size 멤버와 생성자를 변경하는 순간, IceCream 생성자를 사용하는 모든곳이 변경이 필요해요. 🥲
    // var size: Int

    init(flavour: String) {
        self.flavour = flavour
    }

    func finish() {
        print("Icecream is completed...")
    }
}
*/

/*

// MARK: Section 3: Singleton Design Pattern

final class ColorPicker {
    var colors: [UIColor] = [.gray, .green, .red]
    nonisolated(unsafe) static let shared: ColorPicker = .init()

    // 싱글톤 객체는 다른 인스턴스가 생성되지 않도록 생성자를 private 하게 지정한다.
    private init() {

    }

    func getRandomColor() -> UIColor? {
        return colors.randomElement()
    }
}

class A {
    init() {
        // 싱글톤 객체를 접근하는 유일한 방법
        if let color = ColorPicker.shared.getRandomColor() {
            print(color)
        }
    }

    func addColor(color: UIColor) {
        ColorPicker.shared.colors.append(color)
    }
}

class B {
    init() {
        if let color = ColorPicker.shared.getRandomColor() {
            print(color)
        }
    }

    func displayColors() {
        print(ColorPicker.shared.colors)
    }
}

class C {
    init() {
        if let color = ColorPicker.shared.getRandomColor() {
            print(color)
        }
    }

    func displayColors() {
        print(ColorPicker.shared.colors)
    }
}

let a: A = A()
let b: B = B()
let c: C = C()

print("Testing Data Members")

// global 하게 A에서 color를 추가하고, 추가한 color를 포함해서 다른 B 인스턴스에서 출력할 수 있다.
a.addColor(color: .yellow)
b.displayColors()
*/

/*

// MARK: Section 2: Prototype Design Pattern

class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func copy() -> Person {
        return Person(name: name, age: age)
    }

    // Apple Interface 이용하는 경우, NSObject 상속, NSCopying 채택 후 사용 필요
//    func copy(with zone: NSZone? = nil) -> Any {
//        return Person(name: name, age: age)
//    }
}

let person = Person(name: "Min", age: 20)
let person2 = person.copy()
person2.name = "Kim"
person2.age = 30

debugPrint("person name : \(person.name), person2 name : \(person2.name)")
*/
