//
//  Ex03Tests.swift
//
//
//  Created by Antonin on 03/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex03Tests: XCTestCase {
    let report = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ]
    
    func testPart1() throws {
        let toFind: Int = 198
        
        switch Ex03.shared.part1(value: report) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 230
        
        switch Ex03.shared.part2(value: report) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part2: \(err)")
            XCTFail()
        }
    }
}
