[![iOS 16.0+](https://img.shields.io/badge/iOS-16.0+-EAEAEA.svg?style=flat)](https://support.apple.com/ko-kr/118723)
[![Swift 5.0](https://img.shields.io/badge/swift-5.0-F05138.svg?style=flat)](https://swift.org/download/)
[![Xcode 16.2](https://img.shields.io/badge/Xcode-16.2-147EFB.svg?style=flat&color=blue)](https://developer.apple.com/xcode/)
[![RxSwift 6.9.0](https://img.shields.io/badge/RxSwift-6.9.0-B7178C.svg?style=flat)](https://github.com/ReactiveX/RxSwift)
[![lang](https://img.shields.io/badge/lang-ko-147EFB.svg?style=flat&color=3b3b3b)](https://swift.org/download/)

# 🐣 iOS 다마고치 키우기

'ios-tamagotchi'는 다마고치에게 밥알과 물방울을 주어 캐릭터를 성장시키는 어플리케이션(iOS)입니다.

&nbsp;

## ✓ 개발 인원 및 기간

- **기간**: 2025.02.20 ~ 2025.02.24 [4일]

- **인원**: [Goo](https://github.com/Goohyun3436) [1명]

&nbsp;

## ✓ 앱 소개

'ios-tamagotchi'는 밥알과 물방울을 먹으며,<br />
무럭무럭 자라나는 다마고치를 키우는 앱입니다.<br />
3종의 다마고치가 준비되어 있고, 마음에 드는 다마고치를 선택하여<br />
꾸준히 먹이를 주며 성장시키는 즐거움을 경험할 수 있습니다.

&nbsp;

## ✓ 앱 기술 스택

> 아키텍처/디자인 패턴

- MVVM + Input-Output
- BaseView/BaseViewModel/BaseViewController

> 프레임워크

- UIKit

> 라이브러리

- [![RxSwift](https://img.shields.io/badge/RxSwift-6.9.0-B7178C.svg?style=flat)](https://github.com/ReactiveX/RxSwift)
  - [![RxGesture](https://img.shields.io/badge/RxGesture-4.0.4-B7178C.svg?style=flat)](https://github.com/RxSwiftCommunity/RxGesture)
- [![SnapKit](https://img.shields.io/badge/SnapKit-5.7.1-2899b0.svg?style=flat)](https://github.com/SnapKit/SnapKit)

&nbsp;

## ✓ 앱 주요 기능

> 🌕 라이트모드를 지원합니다.

<img width="200px" src="https://github.com/user-attachments/assets/f72f5599-b49f-4cdc-bb36-cce052e08ee7" />

#

> 🥚 다마고치 선택
>
> 3종의 다마고치가 준비되어 있고, 마음에 드는 다마고치를 선택해 키울 수 있습니다.

<img width="200px" src="https://github.com/user-attachments/assets/bc8c93b1-4471-4964-85fd-53eb9480997d" />

<img width="200px" src="https://github.com/user-attachments/assets/1cc2ee12-678a-436d-91d2-150a9dceaa49" />

#

> 🍚 다마고치 먹이
>
> 다마고치에게 밥알과 물방울을 먹이면 경험치가 상승하고 레벨이 올라갑니다.

<img width="200px" src="https://github.com/user-attachments/assets/f72f5599-b49f-4cdc-bb36-cce052e08ee7" />

<img width="200px" src="https://github.com/user-attachments/assets/fceb1aa4-cc8d-4dc9-80ae-2ff142aa707e" />

<img width="200px" src="https://github.com/user-attachments/assets/02f0a876-a706-435d-ac6e-54811d3e1923" />

#

> 🐥 다마고치 변경
>
> 기존의 경험치와 레벨을 유지하면서, 다마고치를 키우는 중에 다른 다마고치로 변경할 수 있습니다.

<img width="200px" src="https://github.com/user-attachments/assets/5a9f584d-8196-4c87-beaa-448c87f5b6c4" />

#

> ✍🏻 대장님 이름 변경
>
> 대장님 이름을 자유롭게 변경할 수 있습니다.

<img width="200px" src="https://github.com/user-attachments/assets/3f9646fe-49e6-4fec-8581-8ddc3b68b243" />

#

> 🗑️ 데이터 초기화
>
> 데이터 초기화를 진행하면 앱에 저장된 모든 데이터가 초기화되고, 온보딩 화면부터 앱이 시작됩니다.

<img width="200px" src="https://github.com/user-attachments/assets/1534f2a8-f1d0-43f8-b333-9414d2a1feb6" />

&nbsp;

## ✓ 기술적 도전

> RxSwift

- View와 ViewModel 간의 복잡한 이벤트 처리를 input, output 구조로 바인딩하여 코드의 가독성과 재사용성을 높였습니다.

- withunretained 연산자를 활용하여 View와 ViewModel 간의 순환 참조 등으로 인한 메모리 누수를 방지하였습니다.

> @propertyWrapper

- propertyWrapper를 활용하여 UserDefaults 기반의 앱 데이터 관리 로직의 가독성과 재사용성을 높였습니다.

&nbsp;

## ✓ 트러블슈팅

> 버튼 이벤트의 중복 호출

- 문제 상황

  - 밥먹기 & 물먹기 버튼의 연속 이벤트 발생 시 UI 업데이트가 제대로 이루어지지 않거나, 경험치가 과도하게 상승하는 문제가 발생했습니다.

- 원인 분석

  - 밥먹기 & 물먹기 버튼 클릭 시, 무조건 경험치가 상승하도록 로직이 구성되어 있습니다.

- 해결 방법

  - `throttle` 오퍼레이터를 사용하여 빠른 연속 탭을 제한하였습니다.

- 결과

  - 경험치와 말풍선, 다마고치 이미지 등 UI 업데이트 미적용 오류를 해결하고, 경험치가 과도하게 상승하는 문제를 해결하였습니다.

&nbsp;

> 화면 간 값 전달 및 상태 동기화

- 문제 상황

  - 다마고치를 변경한 후 홈 화면으로 이동할 때, 선택된 다마고치 정보가 반영되지 않는 문제가 발생하였습니다.

- 원인 분석

  - 각 화면에서 ViewModel을 새로 생성했기 때문에 화면 간 상태가 동기화되지 않았습니다.

- 해결 방법

  - 의존성 주입(Dependency Injection) 방식으로 ViewModel을 다음 화면의 ViewController에 전달하였습니다.

  - 공통 상태 저장소로 UserDefaults를 사용하였으며, `BehaviorSubject`를 사용하여 ViewModel 간 상태 일관성을 확보하였습니다.

- 결과

  - 다마고치를 변경한 후 홈 화면으로 이동하면, 선택된 다마고치 정보와 기존의 경험치 정보가 병합된 UI로 업데이트 해주었습니다.

  &nbsp;
