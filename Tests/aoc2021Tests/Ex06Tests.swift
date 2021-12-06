//
//  Ex06Tests.swift
//
//
//  Created by Antonin on 06/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex06Tests: XCTestCase {
    func testPart1() throws {
        let toFind: Int = 5934
        
        switch Ex06.shared.part1(value: "3,4,3,1,2") {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 26984457539
        
        switch Ex06.shared.part2(value: "3,4,3,1,2") {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
