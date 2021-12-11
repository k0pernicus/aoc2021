//
//  Ex11Tests.swift
//
//
//  Created by Antonin on 11/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex11Tests: XCTestCase {
    let inputTest: [String] = [
        "5483143223",
        "2745854711",
        "5264556173",
        "6141336146",
        "6357385478",
        "4167524645",
        "2176841721",
        "6882881134",
        "4846848554",
        "5283751526"
    ]
    
    func testPart1() throws {
        let toFind: Int = 1656
        
        switch Ex11.shared.part1(value: inputTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 195
        
        switch Ex11.shared.part2(value: inputTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
