import XCTest
@testable import aoc2021

final class Ex01Tests: XCTestCase {
    func testPart1() throws {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        XCTAssertEqual(true, true)
    }
}
