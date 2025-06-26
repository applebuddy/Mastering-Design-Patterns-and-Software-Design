# Mastering-Design-Patterns-and-Software-Design
Mastering Design Patterns and Software Design



- Design Pattern : 소프트웨어 설계 및 개발에서 직면하는 일반적 문제들에 적용 가능한 재사용가능한 해결책
- creational, structural, behavioral design pattern 세가지로 분류할 수 있다.
  - creational : singleton pattern
  - structural : proxy pattern
  - behavioral : observer pattern, responsibility pattern

### Prototype Design Pattern

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
