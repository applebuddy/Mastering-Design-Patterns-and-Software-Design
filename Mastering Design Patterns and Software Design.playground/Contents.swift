import UIKit

// MARK: Singleton Design Pattern

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

/*

// MARK: Prototype Design Pattern

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
