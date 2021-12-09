//
//  Ex09Tests.swift
//
//
//  Created by Antonin on 09/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex09Tests: XCTestCase {
    let input: [String] = [
        "2199943210",
        "3987894921",
        "9856789892",
        "8767896789",
        "9899965678"
    ]
    
    func testPart1() throws {
        let toFind: Int = 15
        
        switch Ex09.shared.part1(value: input) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 1134
        
        switch Ex09.shared.part2(value: input) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
