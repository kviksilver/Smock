import UIKit
import XCTest
@testable import Smock_Example
import Smock


class ProtocolUnderTestMock: NSObject,
ProtocolUnderTest,
Mock
{
    func functionToImplement() {
        registerSelector(#selector(functionToImplement))
    }
}


class TestingProtocolExtensions: XCTestCase {
    
    var protocolUnderTest: ProtocolUnderTestMock!
    
    override func setUp() {
        super.setUp()
        protocolUnderTest = ProtocolUnderTestMock()
    }

    override func tearDown() {
        protocolUnderTest.stopMocking()
        super.tearDown()
    }
    
    func test_registerSelectorCall_PERFORMS_no_calls() {
        XCTAssertSelectorCalls(protocolUnderTest, #selector(ProtocolUnderTestMock.functionToImplement), 0)
    }

    func test_registerSelectorCall_PERFORMS_one_call() {
        protocolUnderTest.functionToTest()
        XCTAssertSelectorCalls(protocolUnderTest, #selector(ProtocolUnderTestMock.functionToImplement), 1)
    }
    
    func test_registerSelectorCall_PERFORMS_multiple_calls() {
        let numberOfCalls = 4
        (0 ..< numberOfCalls).forEach { _ in
            protocolUnderTest.functionToTest()
        }
        XCTAssertSelectorCalls(protocolUnderTest, #selector(ProtocolUnderTestMock.functionToImplement), numberOfCalls)
    }
}
