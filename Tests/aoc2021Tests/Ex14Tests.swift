//
//  Ex14Tests.swift
//
//
//  Created by Antonin on 14/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex14Tests: XCTestCase {
    let inputTest: [String] = [
        "NNCB",
        "",
        "CH -> B",
        "HH -> N",
        "CB -> H",
        "NH -> C",
        "HB -> C",
        "HC -> B",
        "HN -> C",
        "NN -> C",
        "BH -> H",
        "NC -> B",
        "NB -> B",
        "BN -> B",
        "BB -> N",
        "BC -> B",
        "CC -> N",
        "CN -> C",
    ]
    
    func testPart1() throws {
        let toFind: Int = 1588
        
        switch Ex14.shared.part1(value: inputTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 2188189693529

        switch Ex14.shared.part2(value: inputTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
