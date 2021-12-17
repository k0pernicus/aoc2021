//
//  Ex17Tests.swift
//
//
//  Created by Antonin on 17/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex17Tests: XCTestCase {
    func testParseInput() throws {
        let inputTests: [String: ((Int, Int), (Int, Int))] = [
            "target area: x=20..30, y=-10..-5": ((20, 30), (-10, -5))
        ]
        for (test, toFind) in inputTests {
            guard let output = aoc2021.Ex17.parseInput(input: test) else {
                XCTFail()
                return
            }
            XCTAssertEqual(output.0.0, toFind.0.0)
            XCTAssertEqual(output.0.1, toFind.0.1)
            XCTAssertEqual(output.1.0, toFind.1.0)
            XCTAssertEqual(output.1.1, toFind.1.1)
        }
    }
    
    func testPart1() throws {
        let inputTests: [String: Int] = [
            "target area: x=20..30, y=-10..-5": 45
        ]
        for (test, toFind) in inputTests {
            switch Ex17.shared.part1(value: test) {
            case .ok(let count):
                XCTAssertEqual(count, toFind)
            case .error(let err):
                print("Error for part1: \(err)")
                XCTFail()
            }
        }
    }
    
    func testPart2() throws {
        let inputTests: [String: Int] = [
            "target area: x=20..30, y=-10..-5": 112
        ]
        for (test, toFind) in inputTests {
            switch Ex17.shared.part2(value: test) {
            case .ok(let count):
                XCTAssertEqual(count, toFind)
            case .error(let err):
                print("Error for part1: \(err)")
                XCTFail()
            }
        }
    }
}
