# Mastering-Design-Patterns-and-Software-Design
Mastering Design Patterns and Software Design



- Design Pattern : 소프트웨어 설계 및 개발에서 직면하는 일반적 문제들에 적용 가능한 재사용가능한 해결책, 설계 방식
- creational, structural, behavioral design pattern 세가지로 분류할 수 있다.
  - creational : singleton pattern
  - structural : proxy pattern
  - behavioral : observer pattern, responsibility pattern

## Section 2: Prototype Design Pattern (Creational)

- Prototype Design Pattern은 Creational Design Pattern에 속합니다.
- 기존 객체의 멤버를 활용해서 새로운 객체를 생성 가능
- 기존의 객체는 Prototype, 새로운 객체는 Clone이라 함
- 원본 객체과 동일 멤버 값을 가지면서 원본에 영향을 주지 않는 Clone 객체 생성 가능
- Prototype --copy--> Clone

- ex)
  - copy 메서드로 현재 클래스의 멤버를 주입받은 생성자 호출 결과 반환
  - Prototype, Clone은 다른 메모리를 참조하므로, Clone 변경 시 Prototype의 영향을 받지 않음
  - 클래스가 NSObject class 상속, NSCopying protocol 채택하고, `copy(with zone: NSZone?)` method를 사용해서 Prototype Design Pattern 적용 가능
  - 복사할때 복사되는 멤버가 class 인 경우, 메모리를 공유하고, clone 수정 시 원본에 영향을 줄 수 있으므로 주의
    - Shallow Copy : class는 인스턴스 복사 시 메모리를 공유
    - Deep Copy : struct를 사용하거나 class 이더라도 copy 메서드로 새로운 인스턴스를 생성하는 방식으로 멤버를 전달하면 메모리 공유없이 clone 생성 가능 



## Section 3: Singleton Design Pattern (Creational)

- Creational Design Pattern
- class가 오직 단 하나만 생성되도록 제한
- 시스템 내에서 필요한 영역 내에서 global하게 단일 인스턴스를 사용 가능
- Database Helper, Network Manager 등에서 활용 가능
- global하게 사용될 필요가 없거나, 시스템 내에서 단일 인스턴스로 대표할 필요가 없으면 불필요한 Design Pattern이 될 수 있음
- Data races 문제 등 방지를 위한 동시성 보호 고려가 필요함
- iOS 기본 SDK에 싱글톤 객체들이 있습니다.
  - ex) UIApplication, UserDefaults, NotificationCenter ...
- final 키워드
  - final 키워드를 사용하면, 해당 클래스는 서브클래스가 될 수 없다. 컴파일러가 해당 타입을 추론하기 쉬워짐
  - static dispatch 방식으로 사용 -> 컴파일러가 해당 클래스의 타입을 쉽게 추론할 수 있게하여 응용프로그램 성능 향상



### Section 4: System Design Fundamentals & Terminology

- 모든 시스템에는 종속성 그래프가 있습니다.
- Dependency
  - 시스템 목표를 달성하기 위해 객체 간에는 종속성이 존재합니다.
  - ex) Person 클래스는 CreditCard 클래스 인스턴스 등을 하위 attributes로 갖고 있을 수 있습니다. Person 클래스의 역할을 수행하기 위해서는 CreditCard 클래스 인스턴스가 필요하므로 직접적인 의존성이 됩니다.
- 객체간의 의존성으로 인한 변화를 최소화 하기 위해 사이에 추상화를 사용할 수 있습니다.
  - 추상화 미사용 시 : A클래스는 B클래스 구현체의 의존성을 가짐
  - 추상화 사용 시 : A클래스는 C프로토콜을 의존하고, B클래스는 C프로토콜을 채택
    - B클래스가 변경되더라도, 기존 C프로토콜을 준수한다면, A클래스에서의 변경을 막을 수 있음
    - 추상화 사용으로 유연성, 유지보수성, 확장성 증가
  - ex) Person 클래스는 CreditCard protocol 인스턴스를 참조합니다. CreditCard를 채택한 Platinum, MoneyBack 등의 클래스 구현체들이 사용되었을때, 기존 CreditCard를 준수만 한다면, 클래스 구현체가 변경되더라도, Person 클래스에서는 변경이 필요하지 않습니다. 또한 CreditCard 프로토콜을 준수하는 새로운 클래스 구현체를 만들어서 사용할 수도 있습니다.
- Design 에서 중요한 점 (takeaways)
  - 클래스들을 직접적으로 의존하지 마라
    - 클래스 구현체가 아닌 추상화한 프로토콜을 참조하는게 좋다. -> 유연성, 유지보수성, 확장성 이점을 볼 수 있다.



### Section 5: Factory Design Pattern (Creational)

- Creational Design Pattern
- Consumer Class는 Factory에 요청 -> Factory는 내부에서 생성 및 선택을 통해 instance를 반환
- Factory Design Pattern의 장점
  - 객체 생성 및 선택 로직을 가능한 caller 로부터 숨긴다.
  - caller에게 단일 객체를 제공
  - 객체 생성 로직의 확산 방지
  - factory에 interface를 적용해서 의존성을 줄일 수 있음
- 추후 다룰 abstract factory pattern과 깊은 연관이 있음



### Section 6: Abstract Factory Design Pattern (Creational)

- Playground 코드 참고



### Section 7: Builder Design Pattern (Creational)

- 가장 쉽고 간단한 디자인 패턴 중의 하나
- 생성으로 부터 객체의 설정을 분리한다.
- 컴포넌트 호출로부터 객체 생성 로직을 숨깁니다.
- 객체를 위한 default value를 쉽게 설정할 수 있다.
- Builder는 초기 생성 시 default value로 설정된다.
- Builder 생성 후, configuration 메서드로 추가 설정이 가능, Builder 설정 완료 후 인스턴스를 생성 가능

```swift
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
```



### Section 8: Object Pool Design Pattern (Creational)

- 이미 존재하는 객체는 재사용함으로서 객체들의 비싼 초기화 비용을 피한다.
- 컴포넌트 호출로부터 생성로직을 숨긴다. (기존에 존재하는 경우, 해당 인스턴스를 재사용)
- 실세계 자원 컬렉션을 표현한다.
- 단일 객체만 사용하는 경우, Singleton Design Pattern을 사용해도 된다.
- 두개 이상의 객체를 사용하는 경우, Object Pool Design Pattern 사용 가능
  - Singleton은 단일객체로만 관리한다면, Object Pool은 다수의 객체를 collection으로 관리



### Section 9: Creational Patterns - Takeaway

- Creational Patterns의 핵심은 컴포넌트 호출로부터 생성 로직을 숨기는 것
- 구체적타입이 아닌, 추상화타입을 참조하도록 해서 객체간의 의존성을 줄인다.
- 비싼 생성 비용을 줄이기 위해 노력한다.
  - 존재하는 객체를 재사용할 수 있다.
- 유연하고, 확장가능하고, 유지보수가능한 객체 관리가 되도록 노력한다.



### Section 10: Adapter Design Pattern (Structural)

- 소프트웨어 엔지니어링에서 많이 사용되는 패턴
- 두개의 적합하지 않은 인터페이스들을 같이 동작하도록 허용해줍니다.
- 기존 코드를 변경해서는 안될때 사용될 수 있다.
- 기존 코드 변경 없이 인터페이스들을 유연하게 동작하도록 할때 사용될 수 있다.



### Section 11: Bridge Design Pattern (Structural)

- Bridge Design Pattern은 추상화(Abstraction)를 구현체(Implementation)로부터 분리하여, 유연하게 확장할 수 있도록 하는 구조
- Exploding class hierachies(상속의 .. 상속이 생기는 것)라는 공통 상속 설계 문제를 해결할 수 있다.
- protocol을 사용한 컴포지션 (composition)이 (상속)inheritence보다 선호됩니다.
  - 컴포지션은 has a 관계, 상속은 is a 관계



### Section 12: Composite Design Pattern (Structural)

- Composite Design Pattern은 트리 계층의 표현과 관리가 쉽고 유연한 장점이 있다.
- 단순하고, 유연한 방식으로 트리 계층을 생성하도록 해준다.
- 트리 내에서 두가지 타입의 객체가 존재한다. (Leaf or Composite)
- Leaf 객체는 individual, part노드 로도 불린다.
- Composite 객체는 collection, whole노드로도 불린다.



### Section 13: Proxy (Structural)

- Proxy Design Pattern은 실제 자원을 호출자로부터 숨깁니다.
- 호출자는 Proxy를 사용하며, Proxy가 실제 자원에 대한 호출자 요청 대리자를 수행합니다.
- |Caller| -- (Uses) --> |Proxy| -- (Delegates) --> Resource
  - 호출자는 실제 자원에 대해서 알 수 없습니다. Proxy가 대신 실제 자원에 요청하기 때문
- Proxy에 추상화를 적용하여 커플링을 완화하고 실제 자원에 수정사항이 발생해도 호출자에게 영향을 주지 않습니다.
- Proxy는 caller의 권한에 때라 요청을 제한할 수도 있습니다.



### Section 14: Facade (Structural)

- 소비자들에게 단순화된 API를 제공하며 의존성들의 복잡성을 숨기는 것
- 소비자들은 실질적 요구 동작 실행을 위해  Facade를 사용
- caller는 facade design pattern을 사용, facade는 내부적으로 class A, B, C를 사용
- calling components 와의 커플링을 줄임



### Section 15: Decorator Design Pattern (Structural)

- 런타임에 클래스 변경 없이 객체에 행위들을 추가하는것을 허용해준다.
  - 동일한 프로토콜을 채택한 객체들을 생성자에 주입 -> 정의된 메서드 호출을 통해 mix and match 동작
  - mix and match : **여러 기능(데코레이터)을 조합해서 객체에 유연하게 기능을 추가**할 수 있다는 의미
- 행위 추가가 쉽다.
- 일반 상속에 비해서 유연합니다.



### Section 16: FlyWeight Design Pattern (Structural)

- 다수 호출되는 컴포넌트들에 의해 요구되는 많은 유사 객체들의 생성을 방지해준다.
  - 불필요한 메모리 사용 방지, 앱 성능개선에 도움
- FlyWeight 객체는 intrinsic, extrinsic 의 두가지 state를 가진다. (내적, 외적 상태)
- intrinsic state는 변경되지 않는다. 



### Section 17: Chain of Responsibility (Behavioral)

- 행동 패턴 중 하나, 책임 사슬
- 체인의 모든 클래스는 동일한 프로토콜 혹은 부모 클래스 비즈니스를 준수해야함
- 대표적인 예로 UIResponder가 있다.



### Section 18: Strategy Design Pattern (Behavioral)

- 동작을 위한 다수의 알고리즘을 구현하고, 런타임에 설정에 맞는 올바른 알고리즘을 선택하게 해준다.
  - ex) environment가 develop, production 인지에 따라 그에 맞는 구현체를 사용
- Common protocol에 모든 알고리즘이 구현됩니다.



### Section 19: Template Design Pattern (Behavioral)

- Template Design Pattern은 알고리즘의 스탭을 변경할 수 있다.
- 동작에 대한 default step을 정의하고, 이후 재정렬할 수도 있다.
- pattern 구현에 특별한 어려운 점은 없고, 쉽게 구현 가능하다.
- ex)
  - protocol A의 extension method로 default step 순서의 동작 메서드, make()를 정의
  - protocol A를 채택한 구현체들에서 default step 동작이 필요하면, 기존 protocol의 extension method를 활용
  - protocol A를 채택한 구현체들에서 다른 순서의 step 동작이 필요하면, 기존 protocol의 extension method를 재정의
    - shadowing (기본 구현을 가리는 의미의 개념), overriding the protocol requirement (프로토콜 요구사항을 재정의하는것)으로 불림 feat. chatGPT

### Section 20: Observer Design Pattern (Behavioral)

- 상태가 변경될때 Observer들에게 알림을 보냅니다.
- 객체들이 객체의 상태변화를 구독하고, 상태가 변경되면 알림을 받습니다.
- 알림을 등록하는 객체들은 Observers, Listeners라고 합니다.
- ex)
  - Subject(Teacher)는 구독한 Observer(Student)들을 갖고, 필요한 시점에 구독자들에게 이벤트를 전달



### Section 21: Mediator Design Pattern (Behavioral)

- 관련 객체들관의 커뮤니케이션을 담당
- 커플링 약화(decouple)를 위해서 interactor를 사용합니다.
- mediator를 통해서 관련 객체들이 소통하도록 합니다.
- ex) 
  - controlTower는 aeroPlane, zet, chopper 객체를 참조한다. 
  - aeroPlane의 message를 mediator인 controlTower가 zet, chopper로 전달한다.



### Section 22: State Design Pattern (Behavioral)

- 내부 상태가 변경되면 객체 행위를 변경한다.
- 객체 행위를 변경하는 새로운 인스턴스 할당으로 객체의 내부 상태를 변경한다.
- 런타임에 객체 행위 변경이 가능하며 유연함
- ex) 
  - Bike class 내에 GearState가 존재, GearState에 할당되는 구현체 타입에 따라 행위가 변경
  - GearState(gearUp, gearDown method 정의)를 준수하는 FirstGear, SecondGear, ThirdGear, FourthGear가 상황에 따라 할당되고, 그에 맞게 동작이 변경
