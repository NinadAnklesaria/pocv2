import XCTest
@testable import crack_station

final class crack_stationTests: XCTestCase {
    func testExample() throws {
        //when
        let hash = "e0c9035898dd52fc65c41454cec9c4d2611bfb37"
        let out = CrackStation().decrypt(shaHash: hash) ?? nil

        //let lookupTable = try loadDictionaryFromDisk()
        //let answer = lookupTable[""]
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(out, "aa")
    }
}
