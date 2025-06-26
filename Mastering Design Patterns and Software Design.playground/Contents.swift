import UIKit

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
