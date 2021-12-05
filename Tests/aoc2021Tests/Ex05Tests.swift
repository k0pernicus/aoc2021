//
//  Ex05Tests.swift
//
//
//  Created by Antonin on 05/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex05Tests: XCTestCase {
    let testVents: [String] = [
        "0,9 -> 5,9",
        "8,0 -> 0,8",
        "9,4 -> 3,4",
        "2,2 -> 2,1",
        "7,0 -> 7,4",
        "6,4 -> 2,0",
        "0,9 -> 2,9",
        "3,4 -> 1,4",
        "0,0 -> 8,8",
        "5,5 -> 8,2"
    ]
    
    func testParser() throws {
        var segments: [VentSegment] = []
        for line in testVents {
            guard let segment = VentSegment(line: line) else {
                continue
            }
            segments.append(segment)
        }
        let board = VentsBoard(segments: segments, allows: .row, .column)
        XCTAssert(board.board.keys.count == 10)
    }
    
    func testPart1() throws {
        let toFind: Int = 5
        
        switch Ex05.shared.part1(value: testVents) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 12
        
        switch Ex05.shared.part2(value: testVents) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
