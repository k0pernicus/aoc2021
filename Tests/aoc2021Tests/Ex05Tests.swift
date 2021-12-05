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
    
    func testVentSegment() throws {
        let tests = ["", " ", " -> ", "0,0 -> ", "-> 0,1"]
        for test in tests {
            guard VentSegment(line: test) == nil else {
                XCTFail("Parsing \(test) was fine, should fail")
                continue
            }
            continue
        }
        let segment = VentSegment(line: "0,1 -> 2,3")
        if segment == nil {
            XCTFail("Failed to parse a valid string")
        }
        if segment?.from.0 != 0 || segment?.from.1 != 1 {
            XCTFail("'from' from valid string should be (0,1), got \(segment!.from)")
        }
        if segment?.to.0 != 2 || segment?.to.1 != 3 {
            XCTFail("'from' from valid string should be (2,3), got \(segment!.to)")
        }
    }
    
    func testVentColumn() throws {
        XCTAssert(ventColumn(VentSegment(line: "0,0 -> 0,9")!) == nil)
        XCTAssert(ventColumn(VentSegment(line: "0,0 -> 1,9")!) == nil)
        let vents: [Vent]? = ventColumn(VentSegment(line: "0,0 -> 1,0")!)
        XCTAssert(vents != nil)
        XCTAssert(vents!.count == 2)
        XCTAssert(vents![0] == (0,0))
        XCTAssert(vents![1] == (1,0))
    }
    
    func testVentRow() throws {
        XCTAssert(ventRow(VentSegment(line: "0,0 -> 9,0")!) == nil)
        XCTAssert(ventRow(VentSegment(line: "0,0 -> 1,9")!) == nil)
        let vents: [Vent]? = ventRow(VentSegment(line: "0,0 -> 0,1")!)
        XCTAssert(vents != nil)
        XCTAssert(vents!.count == 2)
        XCTAssert(vents![0] == (0,0))
        XCTAssert(vents![1] == (0,1))
    }
    
    func testVentDiagonal() throws {
        XCTAssert(ventDiagonal(VentSegment(line: "0,0 -> 9,0")!) == nil)
        XCTAssert(ventDiagonal(VentSegment(line: "0,0 -> 1,9")!) == nil)
        let vents: [Vent]? = ventDiagonal(VentSegment(line: "0,0 -> 2,2")!)
        XCTAssert(vents != nil)
        XCTAssert(vents!.count == 3)
        XCTAssert(vents![0] == (0,0))
        XCTAssert(vents![1] == (1,1))
        XCTAssert(vents![2] == (2,2))
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
