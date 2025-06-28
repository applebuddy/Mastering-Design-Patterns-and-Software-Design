# Mastering-Design-Patterns-and-Software-Design
Mastering Design Patterns and Software Design



- Design Pattern : 소프트웨어 설계 및 개발에서 직면하는 일반적 문제들에 적용 가능한 재사용가능한 해결책
- creational, structural, behavioral design pattern 세가지로 분류할 수 있다.
  - creational : singleton pattern
  - structural : proxy pattern
  - behavioral : observer pattern, responsibility pattern

## Section 2: Prototype Design Pattern

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



## Section 3: Singleton Design Pattern

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



### Section 5: Factory Design Pattern

- Creational Design Pattern
- Consumer Class는 Factory에 요청 -> Factory는 내부에서 생성 및 선택을 통해 instance를 반환
- Factory Design Pattern의 장점
  - 객체 생성 및 선택 로직을 가능한 caller 로부터 숨긴다.
  - caller에게 단일 객체를 제공
  - 객체 생성 로직의 확산 방지
  - factory에 interface를 적용해서 의존성을 줄일 수 있음
- 추후 다룰 abstract factory pattern과 깊은 연관이 있음
