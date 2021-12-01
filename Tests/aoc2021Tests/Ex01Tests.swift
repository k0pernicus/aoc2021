//
//  Ex01Tests.swift
//
//
//  Created by Antonin on 21/11/2021.
//

import XCTest
@testable import aoc2021

final class Ex01Tests: XCTestCase {
    let depthsTest: [Int] = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    
    func testPart1() throws {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }
        
        let toFind: Int = 7
        
        switch Ex01.shared.part1(value: depthsTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }
        
        let toFind: Int = 5
        
        switch Ex01.shared.part2(value: depthsTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
