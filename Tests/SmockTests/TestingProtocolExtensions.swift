import Foundation
import XCTest
import Smock

class TestingProtocolExtensions: XCTestCase {

    var protocolUnderTest: ProtocolUnderTestMock!

    override func setUp() {
        super.setUp()
        protocolUnderTest = ProtocolUnderTestMock()
    }

    override func tearDown() {
        protocolUnderTest.stopMocking()
        ProtocolUnderTestMock.stopMocking()
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

    func test_registerSelectorCall_PERFORMS_one_call_WITH_params() {
        let parameter = "test parameters"
        protocolUnderTest.functionToTest_params(params: parameter)

        let parametersReceived = protocolUnderTest.parametersForSelector( #selector(ProtocolUnderTestMock.functionToImplement_params(params:)))

        XCTAssertSelectorCalls(protocolUnderTest, #selector(ProtocolUnderTestMock.functionToImplement_params(params:)), 1)
        XCTAssertEqual(parameter, parametersReceived?[0] as? String)
    }

    func test_registerSelectorCall_PERFORMS_one_call_WITH_returnValue() {
        let returnValue = "test returnValue"
        protocolUnderTest.stubValueForSelector(#selector(ProtocolUnderTestMock.functionToImplement_return), returnValue)

        let returnedValue = protocolUnderTest.functionToTest_return()

        XCTAssertSelectorCalls(protocolUnderTest, #selector(ProtocolUnderTestMock.functionToImplement_return), 1)
        XCTAssertEqual(returnValue, returnedValue)
    }

    func test_registerSelectorCall_PERFORMS_one_call_WITH_params_returnValue() {
        let parameter = "test parameters"
        let returnValue = "test returnValue"
        protocolUnderTest.stubValueForSelector(#selector(ProtocolUnderTestMock.functionToImplement_params_return(params:)), returnValue)

        let returnedValue = protocolUnderTest.functionToTest_params_return(params: parameter)
        let parametersReceived = protocolUnderTest.parametersForSelector( #selector(ProtocolUnderTestMock.functionToImplement_params_return(params:)))

        XCTAssertSelectorCalls(protocolUnderTest, #selector(ProtocolUnderTestMock.functionToImplement_params_return(params:)), 1)
        XCTAssertEqual(parameter, parametersReceived?[0] as? String)
        XCTAssertEqual(returnValue, returnedValue)
    }

    func test_registerSelectorCall_static_PERFORMS_no_calls() {
        XCTAssertSelectorCalls(ProtocolUnderTestMock.self, #selector(ProtocolUnderTestMock.functionToImplement_static), 0)
    }

    func test_registerSelectorCall_static_PERFORMS_one_call() {
        ProtocolUnderTestMock.functionToTest_static()

        XCTAssertSelectorCalls(ProtocolUnderTestMock.self, #selector(ProtocolUnderTestMock.functionToImplement_static), 1)
    }

    func test_registerSelectorCall_static_PERFORMS_multiple_calls() {
        let numberOfCalls = 4
        (0 ..< numberOfCalls).forEach { _ in
            ProtocolUnderTestMock.functionToTest_static()
        }

        XCTAssertSelectorCalls(ProtocolUnderTestMock.self, #selector(ProtocolUnderTestMock.functionToImplement_static), numberOfCalls)
    }

    func test_registerSelectorCall_static_PERFORMS_one_call_WITH_params() {
        let parameter = "test parameters"
        ProtocolUnderTestMock.functionToTest_params_static(params: parameter)

        let parametersReceived = ProtocolUnderTestMock.parametersForSelector( #selector(ProtocolUnderTestMock.functionToImplement_params_static(params:)))

        XCTAssertSelectorCalls(ProtocolUnderTestMock.self, #selector(ProtocolUnderTestMock.functionToImplement_params_static(params:)), 1)
        XCTAssertEqual(parameter, parametersReceived?[0] as? String)
    }

    func test_registerSelectorCall_static_PERFORMS_one_call_WITH_returnValue() {
        let returnValue = "test returnValue"
        ProtocolUnderTestMock.stubValueForSelector(#selector(ProtocolUnderTestMock.functionToImplement_return_static), returnValue)

        let returnedValue = ProtocolUnderTestMock.functionToTest_return_static()

        XCTAssertSelectorCalls(ProtocolUnderTestMock.self, #selector(ProtocolUnderTestMock.functionToImplement_return_static), 1)
        XCTAssertEqual(returnValue, returnedValue)
    }

    func test_registerSelectorCall_static_PERFORMS_one_call_WITH_params_returnValue() {
        let parameter = "test parameters"
        let returnValue = "test returnValue"
        ProtocolUnderTestMock.stubValueForSelector(#selector(ProtocolUnderTestMock.functionToImplement_params_return_static(params:)), returnValue)

        let returnedValue = ProtocolUnderTestMock.functionToTest_params_return_static(params: parameter)
        let parametersReceived = ProtocolUnderTestMock.parametersForSelector( #selector(ProtocolUnderTestMock.functionToImplement_params_return_static(params:)))

        XCTAssertSelectorCalls(ProtocolUnderTestMock.self, #selector(ProtocolUnderTestMock.functionToImplement_params_return_static(params:)), 1)
        XCTAssertEqual(parameter, parametersReceived?[0] as? String)
        XCTAssertEqual(returnValue, returnedValue)
    }

}
