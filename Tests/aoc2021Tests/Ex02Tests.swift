//
//  Ex02Tests.swift
//
//
//  Created by Antonin on 02/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex02Tests: XCTestCase {
    let test: [String] = [
        "forward 5",
        "down 5",
        "forward 8",
        "up 3",
        "down 8",
        "forward 2",
    ]
    
    func testPart1() throws {
        let toFind: Int = 150
        
        switch Ex02.shared.part1(value: test) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 900
        
        switch Ex02.shared.part2(value: test) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
