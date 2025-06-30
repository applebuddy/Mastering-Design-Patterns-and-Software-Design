import UIKit

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
