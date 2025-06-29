import UIKit

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
