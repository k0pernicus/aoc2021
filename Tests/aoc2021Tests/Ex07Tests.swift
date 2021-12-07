//
//  Ex07Tests.swift
//
//
//  Created by Antonin on 07/12/2021.
//

import XCTest
@testable import aoc2021

let testInput = "16,1,2,0,4,2,7,1,2,14"

final class Ex07Tests: XCTestCase {
    func testPart1() throws {
        let toFind: Int = 37
        
        switch Ex07.shared.part1(value: testInput) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 168
        
        switch Ex07.shared.part2(value: testInput) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
