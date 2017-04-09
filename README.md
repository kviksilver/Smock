# Smock

[![CI Status](http://img.shields.io/travis/kviksilver/Smock.svg?style=flat)](https://travis-ci.org/kviksilver/Smock)
[![Version](https://img.shields.io/cocoapods/v/Smock.svg?style=flat)](http://cocoapods.org/pods/Smock)
[![License](https://img.shields.io/cocoapods/l/Smock.svg?style=flat)](http://cocoapods.org/pods/Smock)
[![Platform](https://img.shields.io/cocoapods/p/Smock.svg?style=flat)](http://cocoapods.org/pods/Smock)

Smock makes testing protocol extensions in Swift easier by providing capability to record selector calls, parameters and stub return values

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Look for `ProtocolUnderTest`, `ProtocolUnderTestMock` and `TestingProtocolExtensions` in example project for more details.

Basic example:

Protocol defines following interface
```Swift
protocol ProtocolUnderTest: class {
    func functionToTest()
    func functionToImplement()
}
```

Extension implements `functionToTest` that calls `functionToImplement` 
```Swift
extension ProtocolUnderTest {
    func functionToTest() {
        functionToImplement()
    }
}    
```

To test that extension actually does required work (on our case function call) we create a mock in test target that conforms to `ProtocolUnderTest` and `Mock` protocols, implement required `functionToImplement` as follows:

```swift
class ProtocolUnderTestMock: NSObject, ProtocolUnderTest, Mock {}
extension ProtocolUnderTestMock {
    func functionToImplement() {
        registerSelector(#selector(functionToImplement))
    }
}
```


## Requirements

## Installation

Smock is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Smock"
```

## Author

kviksilver, berceg@gmail.com

## License

Smock is available under the MIT license. See the LICENSE file for more info.



