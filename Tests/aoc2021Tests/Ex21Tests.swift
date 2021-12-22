//
//  Ex21Tests.swift
//
//
//  Created by Antonin on 21/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex21Tests: XCTestCase {
    let inputTests: [String] = [
        "Player 1 starting position: 4",
        "Player 2 starting position: 8",
    ]
    
    func testFindPositions() throws {
        let inputTests: [String] = [
            "Player 1 starting position: 4",
            "Player 2 starting position: 8",
        ]
        let toFind: [Int] = [4, 8]
        let results = aoc2021.findPositions(rawStrings: inputTests)
        if results == nil {
            XCTFail()
            return
        }
        for (index, result) in results!.enumerated() {
            XCTAssertEqual(result, toFind[index])
        }
    }
    
    func testPart1() throws {
        let toFind: Int = 739785
        
        switch Ex21.shared.part1(value: inputTests) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 0
        
        switch Ex21.shared.part2(value: inputTests) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
