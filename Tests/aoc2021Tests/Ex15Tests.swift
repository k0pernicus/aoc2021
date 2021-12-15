//
//  Ex15Tests.swift
//
//
//  Created by Antonin on 15/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex15Tests: XCTestCase {
    let inputTest: [String] = [
        "1163751742",
        "1381373672",
        "2136511328",
        "3694931569",
        "7463417111",
        "1319128137",
        "1359912421",
        "3125421639",
        "1293138521",
        "2311944581"
    ]
    
    func testPart1() throws {
        let toFind: Int = 40
        
        switch Ex15.shared.part1(value: inputTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 307

        switch Ex15.shared.part2(value: inputTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
