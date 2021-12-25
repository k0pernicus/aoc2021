//
//  Ex25Tests.swift
//
//
//  Created by Antonin on 26/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex25Tests: XCTestCase {
    let test: [String] = [
        "v...>>.vv>",
        ".vv>>.vv..",
        ">>.>v>...v",
        ">>v>>.>.v.",
        "v>v.vv.v..",
        ">.>>..v...",
        ".vv..>.>v.",
        "v.v..>>v.v",
        "....v..v.>",
    ]
    
    func testPart1() throws {
        let toFind: Int = 58
        
        switch Ex25.shared.part1(value: test) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
